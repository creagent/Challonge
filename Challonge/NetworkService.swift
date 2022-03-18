//
//  NetworkService.swift
//  Challonge
//
//  Created by Антон Алексеев on 18.03.2022.
//

import Foundation

class NetworkService<APIEndPoint: EndPoint> {
    private var requestManager = HTTPRequestManager()
    
    @discardableResult
    func executeRequest<ResultType: DataInstantiable>(to endPoint: APIEndPoint,
                                                      completion: @escaping (_ resultData: ResultType?,
                                                                             _ error: Error?) -> Void) -> URLSessionTask? {
        return requestManager.executeRequest(endPoint.httpMethod,
                                             to: endPoint,
                                             headers: endPoint.headers ?? [:],
                                             useDefaultHeaders: endPoint.useDefaultHeaders,
                                             withBody: endPoint.body,
                                             timeout: endPoint.timeout) { (result: HTTPRequestResult<ResultType>) in
            DispatchQueue.main.async {
                switch result.0 {
                case .success(let resultData):
                    completion(resultData, nil)
                case .failure(let error):
                    completion(nil, error)
                }
            }
        }
    }
}
