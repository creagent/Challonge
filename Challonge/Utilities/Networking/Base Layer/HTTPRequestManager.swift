//
//  HTTPRequestManager.swift
//  Challonge
//
//  Created by Антон Алексеев on 18.03.2022.
//

import Foundation
import os.log

class HTTPRequestManager {
    @discardableResult
    func executeRequest<ResultType: DataInstantiable>(_ httpMethod: HTTPMethod = .get,
                                                      to urlConvertible: URLConvertible,
                                                      headers: [String: String] = [:],
                                                      useDefaultHeaders: Bool = true,
                                                      withBody body: DataConvertible? = nil,
                                                      timeout: TimeInterval = RequestTimeout.standard.rawValue,
                                                      completion: @escaping HTTPResponseHandler<ResultType>) -> URLSessionTask? {
        guard ReachabilityManager.isNetworkConnected else {
            completion((.failure(.responseIsMissing), "Network is unavailable"))
            return nil
        }
        
        // URL generation
        var requestURL: URL
        do {
            requestURL = try urlConvertible.getURL()
        } catch {
            completion((.failure(.urlGenerationError(error: error)),
                        OSLog.debugLogString(type: .error, sender: self, message: "Request URL generation error")))
            return nil
        }
        
        // Body generation
        var bodyData: Data?
        if let payload = body {
            do {
                bodyData = try payload.getData()
            } catch {
                completion((.failure(.requestBodyEncodingError(error: error)),
                            OSLog.debugLogString(type: .error, sender: self, message: "Body generation error")))
                return nil
            }
        }
        
        //Request generation
        var request = URLRequest(url: requestURL)
        request.httpMethod = httpMethod.rawValue
        request.timeoutInterval = timeout
        
        //Request callback
        let taskResultHandler = getTaskResultHandler(request: request, requestBody: bodyData,
                                                     bodyData: bodyData, completion: completion)
        
        //Execution
        let task = getTask(with: bodyData, request: request, taskResultHandler: taskResultHandler)
        task.resume()
        
        return task
    }
    
    // MARK: - Private
    private func getTaskResultHandler<ResultType>(request: URLRequest,
                                                  requestBody: Data?,
                                                  bodyData: Data?,
                                                  completion: @escaping HTTPResponseHandler<ResultType>) -> ((Data?, URLResponse?, Error?) -> Void)
    where ResultType: DataInstantiable {
        return { (data: Data?, response: URLResponse?, error: Error?) in
            let debugDescription = OSLog.requestDebugDescription(request: request, requestBody: bodyData, error: error,
                                                                 response: response, responseData: data)
            OSLog.sendLog(message: debugDescription, category: .network, sender: self)
            guard (error as NSError?)?.code != NSURLErrorCancelled else { return }
            
            if let response = response as? HTTPURLResponse {
                let code = response.statusCode
                switch code {
                case 200...299, 500...599:
                    var result: ResultType?
                    if let data = data {
                        do {
                            result = try ResultType(with: data)
                        } catch {
                            completion((.failure(.internalServerError), debugDescription))
                            return
                        }
                    }
                    completion((.success(result), debugDescription))
                case 401...403:
                    completion((.failure(.unauthorizedError), debugDescription))
                case 404:
                    completion((.failure(.notFoundError), "404"))
                default:
                    completion((.failure(.responseIsMissing), debugDescription))
                }
            } else {
                completion((.failure(.responseIsMissing), debugDescription))
            }
        }
    }
    
    private func getTask(with bodyData: Data?, request: URLRequest, taskResultHandler: @escaping ((Data?, URLResponse?, Error?) -> Void)) -> URLSessionTask {
        let session = URLSession.shared
        if let bodyData = bodyData {
            return session.uploadTask(with: request, from: bodyData, completionHandler: taskResultHandler)
        } else {
            return session.dataTask(with: request, completionHandler: taskResultHandler)
        }
    }
}
