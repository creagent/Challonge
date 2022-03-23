//
//  Tournament.swift
//  Challonge
//
//  Created by Антон Алексеев on 22.03.2022.
//

import Foundation

struct Tournament {
    var name: String
    var type: String
    var description: String
    var gameId: Int = 600
    var isPrivate: Bool
    var notifyUsersWhenMatchesOpens: Bool
    var notifyUsersWhenMatchesEnds: Bool
    var holdThirdPlaceMatch: Bool
    var rankedBy: String
    var signupCapacity: Int
    var startDate: Date
}
