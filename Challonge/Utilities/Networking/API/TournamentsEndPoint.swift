//
//  TournamentsEndPoint.swift
//  Challonge
//
//  Created by Антон Алексеев on 18.03.2022.
//

import Foundation

enum TournamentsEndPoint {
    case create(register: TournamentRegister)
    case get
}

extension TournamentsEndPoint: EndPoint {
    var requestEndPoint: String {
        let entityName = "tournaments"
        var method: String?
        var result = "/\(entityName)"
        if let method = method {
            result += "/\(method)"
        }
        return "\(result).json"
    }
    
    var body: EndPointBody? {
        var data: Data
        switch self {
        case .create(let register):
            data = try! JSONEncoder().encode(register)
        default:
            return nil
        }
        return EndPointBody(requestData: data)
    }
    
//    var queryItems: [String: Any]? {
//        var queryItems: [String: Any?] = [:]
//        switch self {
//
//        }
//        return queryItems.compactMapValues({ $0 })
//    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .get:
            return.get
        case .create:
            return .post
        }
    }
}
