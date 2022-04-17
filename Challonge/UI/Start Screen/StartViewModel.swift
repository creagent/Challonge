//
//  StartViewModel.swift
//  Challonge
//
//  Created by Антон Алексеев on 22.03.2022.
//

import Foundation

class StartViewModel {
    private lazy var tournamentService = TournamentsService()
}

// MARK: - API Methods
extension StartViewModel {
    func checkAccess(login: String, apiKey: String,
                     complete: @escaping (Bool) -> Void) {
        BaseEndPoint.setBaseURLString(for: User(name: login, apiKey: apiKey))
        tournamentService.getTournament { _, error in
            if error == nil {
                complete(true)
            } else {
                complete(false)
            }
        }
    }
}
