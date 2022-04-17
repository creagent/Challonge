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

// MARK: - FirstStepViewDelegate
extension FirstStepViewController: FirstStepViewDelegate {
    var navigationBarItem: UINavigationItem? {
        navigationItem
    }
    
    func closeButtonDidPress() {
        dismiss(animated: true)
    }
    
    func nextButtonDidPress() {
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
