//
//  TournamentsEndPoint.swift
//  Challonge
//
//  Created by Антон Алексеев on 18.03.2022.
//

import Foundation

public enum TournamentsEndPoint {
    case create
}

extension TournamentsEndPoint: EndPoint {
    public var requestEndPoint: String {
        let entityName = "tournaments"
        var method = ""
        switch self {
        case .create:
            method = ""
        }
        return "/\(entityName)/\(method)"
    }
    
//    public var body: EndPointBody? {
//        var data: Data
//        switch self {
//
//        }
//        return EndPointBody(requestData: data)
//    }
    
//    public var queryItems: [String: Any]? {
//        var queryItems: [String: Any?] = [:]
//        switch self {
//
//        }
//        return queryItems.compactMapValues({ $0 })
//    }
    
    public var httpMethod: HTTPMethod {
        switch self {
        case .create:
            return .post
        }
    }
}
