//
//  HTTP.swift
//  Challonge
//
//  Created by Антон Алексеев on 18.03.2022.
//

import Foundation

// MARK: - Types
public typealias HTTPRequestResult<ResultType: DataInstantiable> = (Result<ResultType?, HTTPRequestError>, String)
public typealias HTTPResponseHandler<ResultType: DataInstantiable> = (HTTPRequestResult<ResultType>) -> Void
public typealias ResultHandler<ResultType> = (Result<ResultType, Error>) -> Void

public enum HTTPHeaders: String {
    case contentType = "Content-Type"
}

public enum HTTPHeaderContentType: String {
    case json = "application/json"
    case urlEncodedUTF8 = "application/x-www-form-urlencoded; charset=utf-8"
}

public enum HTTPMethod: String {
    case delete = "DELETE"
    case get = "GET"
    case patch = "PATCH"
    case post = "POST"
    case put = "PUT"
}

public enum HTTPRequestError: Error {
    case clientError(code: Int)
    case forbiddenError
    case internalServerError
    case notFoundError
    case requestBodyEncodingError(error: Error)
    case requestExecutionError(error: Error)
    case responseBodyDecodingError(error: Error)
    case responseIsMissing
    case serverError(code: Int)
    case unauthorizedError
    case unknownError
    case unknownResponseStatusCodeError(code: Int)
    case urlGenerationError(error: Error)
}

//public extension Error {
//    var errorViewType: ErrorViewType? {
//        guard let error = self as? HTTPRequestError else { return nil }
//        switch error {
//        case .internalServerError:
//            return .somethingWrong
//        case .unauthorizedError:
//            return .authorizationExpired
//        case .notFoundError:
//            return .notFound
//        case .responseIsMissing:
//            return .connectionLost
//        default:
//            return .somethingWrong
//        }
//    }
//}

public func httpRequestErrorByCode(_ code: Int) -> HTTPRequestError {
    switch code {
    case 401: return .unauthorizedError
    case 403: return .forbiddenError
    case 404: return .notFoundError
    case 400...499: return .clientError(code: code)
    case 500: return .internalServerError
    case 500...599: return .serverError(code: code)
    default: return .unknownResponseStatusCodeError(code: code)
    }
}

public enum RequestTimeout: TimeInterval {
    case standard = 60.0
}
