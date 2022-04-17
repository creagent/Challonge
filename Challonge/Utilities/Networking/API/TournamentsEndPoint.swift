//
//  TournamentsEndPoint.swift
//  Challonge
//
//  Created by Антон Алексеев on 18.03.2022.
//

import Foundation

enum TournamentsEndPoint {
    case create(register: TournamentResponse)
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
    
    var queryItems: [String: Any]? {
        var queryItems: [String: Any?] = [:]
        switch self {
        case .create(let register):
            let tournament = register.tournament
            queryItems = [
                "tournament[\(Tournament.CodingKeys.name.rawValue)]": tournament.name,
                "tournament[\(Tournament.CodingKeys.type.rawValue)]": tournament.type,
                "tournament[\(Tournament.CodingKeys.description.rawValue)]": tournament.description,
                "tournament[\(Tournament.CodingKeys.gameId.rawValue)]": tournament.gameId,
                "tournament[\(Tournament.CodingKeys.isPrivate.rawValue)]": tournament.isPrivate,
                "tournament[\(Tournament.CodingKeys.notifyUsersWhenMatchesOpens.rawValue)]": tournament.notifyUsersWhenMatchesOpens,
                "tournament[\(Tournament.CodingKeys.notifyUsersWhenMatchesEnds.rawValue)]": tournament.notifyUsersWhenMatchesEnds,
                "tournament[\(Tournament.CodingKeys.holdThirdPlaceMatch.rawValue)]": tournament.holdThirdPlaceMatch,
                "tournament[\(Tournament.CodingKeys.rankedBy.rawValue)]": tournament.rankedBy,
                "tournament[\(Tournament.CodingKeys.signupCapacity.rawValue)]": tournament.signupCapacity,
                "tournament[\(Tournament.CodingKeys.startDateString.rawValue)]": tournament.startDateString
            ]
        default:
            break
        }
        return queryItems.compactMapValues({ $0 })
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .get:
            return.get
        case .create:
            return .post
        }
    }
}
