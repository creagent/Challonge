//
//  Tournament.swift
//  Challonge
//
//  Created by Антон Алексеев on 22.03.2022.
//

import Foundation

struct Tournament: Codable {
    var name: String?
    var type: String?
    var description: String?
    var gameId: Int = 600
    var isPrivate: Bool?
    var notifyUsersWhenMatchesOpens: Bool?
    var notifyUsersWhenMatchesEnds: Bool?
    var holdThirdPlaceMatch: Bool?
    var rankedBy: String?
    var signupCapacity: Int?
    var startDateString: String?
    var startDate: Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-ddTHH:mm:ss"
        return dateFormatter.date(from: startDateString ?? "") ?? Date()
    }
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case type = "tournament_type"
        case description = "description"
        case gameId = "game_id"
        case isPrivate = "private"
        case notifyUsersWhenMatchesOpens = "notify_users_when_matches_open"
        case notifyUsersWhenMatchesEnds = "notify_users_when_the_tournament_ends"
        case holdThirdPlaceMatch = "hold_third_place_match"
        case rankedBy = "ranked_by"
        case signupCapacity = "signup_cap"
        case startDateString = "start_at"
    }
}

struct TournamentResponse: Codable {
    var tournament: Tournament
}
