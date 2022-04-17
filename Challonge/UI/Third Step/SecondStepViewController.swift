//
//  ThirdStepViewController.swift
//  Challonge
//
//  Created by Антон Алексеев on 08.04.2022.
//

import UIKit

struct SecondStepInfo {
    var startDateString: String
    var notifyUsersWhenMatchesOpens: Bool
    var notifyUsersWhenMatchesEnds: Bool
    var holdThirdPlaceMatch: Bool
}

class SecondStepViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        secondStepView = SecondStepView(ownerController: self)
        secondStepView.delegate = self
    }
    
    var viewModel: SecondStepViewModel?
    
    private var secondStepView: SecondStepView!
}

extension SecondStepViewController: SecondStepViewDelegate {
    func closeButtonDidPress() {
        dismiss(animated: true)
    }
    
    func createButtonDidPress() {
        secondStepView.isCreateButtonActive = false
        let startDateString = secondStepView.startDateString
        let notifyUsersWhenMatchesOpens = secondStepView.notifyUsersWhenMatchesOpens
        let notifyUsersWhenMatchesEnds = secondStepView.notifyUsersWhenMatchesEnds
        let holdThirdPlaceMatch = secondStepView.holdThirdPlaceMatch
        let info = SecondStepInfo(startDateString: startDateString,
                                  notifyUsersWhenMatchesOpens: notifyUsersWhenMatchesOpens,
                                  notifyUsersWhenMatchesEnds: notifyUsersWhenMatchesEnds,
                                  holdThirdPlaceMatch: holdThirdPlaceMatch)
        viewModel?.updateTournament(with: info)
        viewModel?.createTournament { [weak self] _ in
            self?.secondStepView.isCreateButtonActive = true
            self?.dismiss(animated: true)
        }
    }
    
    var navigationBarItem: UINavigationItem? {
        navigationItem
    }
}
