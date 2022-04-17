//
//  FirstStepViewController.swift
//  Challonge
//
//  Created by Антон Алексеев on 22.03.2022.
//

import UIKit

class FirstStepViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        firstStepView = FirstStepView(ownerController: self)
        firstStepView.delegate = self
    }
    
    private var firstStepView: FirstStepView!
}

extension FirstStepViewController: FirstStepViewDelegate {
    var navigationBarItem: UINavigationItem? {
        navigationItem
    }
    
    func closeButtonDidPress() {
        dismiss(animated: true)
    }
    
    func nextButtonDidPress() {
//        let tournament = Tournament(name: "New", type: "single elimination", description: "description", gameId: 600, isPrivate: false, notifyUsersWhenMatchesOpens: true, notifyUsersWhenMatchesEnds: true, holdThirdPlaceMatch: true, rankedBy: "match wins", signupCapacity: 15, startDateString: "2022-03-30T19:00:00.000+01:00")
//        let register = TournamentResponse(tournament: tournament)
//        TournamentsService().createTournament(register: register)
        let name = firstStepView.tournamentName
        let type = firstStepView.tournamentType
        let description = firstStepView.tournamentDescription
        let isPrivate = firstStepView.isTournamentPrivate
        let tournament = Tournament(name: name, type: type, description: description, gameId: 600, isPrivate: isPrivate)
        let vc = SecondStepViewController()
        let viewModel = SecondStepViewModel(tournament: tournament)
        vc.viewModel = viewModel
        navigationController?.pushViewController(vc, animated: true)
    }
}
