//
//  SecondStepViewModel.swift
//  Challonge
//
//  Created by Антон Алексеев on 10.04.2022.
//

import Foundation

class SecondStepViewModel {
    init(tournament: Tournament) {
        self.tournament = tournament
    }
    
    func updateTournament(with info: SecondStepInfo) {
        tournament.startDateString = info.startDateString
        tournament.holdThirdPlaceMatch = info.holdThirdPlaceMatch
        tournament.notifyUsersWhenMatchesOpens = info.notifyUsersWhenMatchesOpens
        tournament.notifyUsersWhenMatchesEnds = info.notifyUsersWhenMatchesEnds
    }
    
    private var tournament: Tournament
    
    private lazy var tournamentService = TournamentsService()
}

extension SecondStepViewModel {
    func createTournament(complete: @escaping (Bool) -> Void) {
        let register = TournamentResponse(tournament: tournament)
        tournamentService.createTournament(register: register) { _, error in
            if error == nil {
                complete(true)
            } else {
                complete(false)
            }
        }
    }
}
