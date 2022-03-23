//
//  TournamentsEndPoint.swift
//  Challonge
//
//  Created by Антон Алексеев on 18.03.2022.
//

import Foundation

enum TournamentsEndPoint {
    case create
}

extension TournamentsEndPoint: EndPoint {
    var requestEndPoint: String {
        let entityName = "tournaments"
        var method = ""
        switch self {
        case .create:
            method = ""
        }
        return "/\(entityName)/\(method)"
    }
    
//    var body: EndPointBody? {
//        var data: Data
//        switch self {
//
//        }
//        return EndPointBody(requestData: data)
//    }
    
//    var queryItems: [String: Any]? {
//        var queryItems: [String: Any?] = [:]
//        switch self {
//
//        }
//        return queryItems.compactMapValues({ $0 })
//    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .create:
            return .post
        }
    }
}
