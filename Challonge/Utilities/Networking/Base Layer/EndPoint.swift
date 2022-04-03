//
//  EndPoint.swift
//  Challonge
//
//  Created by Антон Алексеев on 18.03.2022.
//

import Foundation

struct User {
    let name: String
    let apiKey: String
}

class BaseEndPoint: EndPoint {
    static var baseURLString: String = "https://api.challonge.com/ru/v1"
    
    static func setBaseURLString(for user: User) {
        let username = user.name
        let apiKey = user.apiKey
        baseURLString = "https://\(username):\(apiKey)@api.challonge.com/ru/v1"
    }
    
    var requestEndPoint: String = ""
    
    var httpMethod: HTTPMethod = .get
    
    static var baseAuthUsername: String?
    static var baseAuthPassword: String?
}

 protocol EndPoint: URLConvertible {
    var baseURL: URL { get }
    var path: String { get }
    var requestEndPoint: String { get }
    var queryItems: [String: Any]? { get }
    var httpMethod: HTTPMethod { get }
    var headers: [String: String]? { get }
    var useDefaultHeaders: Bool { get }
    var body: EndPointBody? { get }
    var timeout: TimeInterval { get }
}

 extension EndPoint {
    var timeout: TimeInterval {
        RequestTimeout.standard.rawValue
    }
    
    var useDefaultHeaders: Bool {
        false
    }
    
     var headers: [String: String]? {
//         var headers = ["\(HTTPHeaders.contentType.rawValue)": "application/json"]
         var headers: [String: String]? = [:]
//         if let username = BaseEndPoint.baseAuthUsername,
//            let password = BaseEndPoint.baseAuthPassword {
//             let loginString = String(format: "%@:%@", username, password)
//             let loginData = loginString.data(using: String.Encoding.utf8)!
//             let base64LoginString = loginData.base64EncodedString()
//             headers["Authorization"] = "Basic \(base64LoginString)"
//         }
         return headers
     }
    
    var queryItems: [String: Any]? {
        nil
    }
    
    var body: EndPointBody? {
        nil
    }
    
    var baseURL: URL {
        guard let url = URL(string: BaseEndPoint.baseURLString) else {
            fatalError()
        }
        return url
    }
    
    var path: String {
        requestEndPoint
    }
}

// MARK: - URLConvertible
 extension EndPoint {
    func getURL() throws -> URL {
        let url = baseURL.appendingPathComponent(path)
        if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false), !(queryItems?.isEmpty ?? true) {
            var urlQueryItems = [URLQueryItem]()
            if let queryItems = queryItems {
                for (key, value) in queryItems {
                    if let value = value as? [Any] {
                        value.forEach { value in
                            urlQueryItems.append(URLQueryItem(name: key + "[]", value: String(describing: value)))
                        }
                    } else {
                        urlQueryItems.append(URLQueryItem(name: key, value: String(describing: value)))
                    }
                }
            }
            urlComponents.queryItems = urlQueryItems
            let set = CharacterSet(charactersIn: "+").inverted
            if let query = urlComponents.query?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)?
                .addingPercentEncoding(withAllowedCharacters: set) {
                urlComponents.percentEncodedQuery = query
            }
            return urlComponents.url ?? url
        }
        return url
    }
}
