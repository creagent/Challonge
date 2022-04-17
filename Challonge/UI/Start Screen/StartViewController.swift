//
//  ViewController.swift
//  Challonge
//
//  Created by Антон Алексеев on 13.03.2022.
//

import UIKit

class StartViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        startView = StartView(ownerController: self)
        startView.delegate = self
    }
    
    private var startView: StartView!
    
    private let viewModel = StartViewModel()
}

// MARK: - Private Methods
private extension StartViewController {
    func openForm() {
        let vc = FirstStepViewController()
        let navVC = UINavigationController()
        navVC.viewControllers = [vc]
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true)
    }
}

// MARK: - StartViewDelegate
extension StartViewController: StartViewDelegate {
    func createButtonDidPress() {
        startView.isCreateButtonActive = false
        viewModel.checkAccess(login: startView.login,
                              apiKey: startView.apiKey) { [weak self] isSuccessful in
            if isSuccessful {
                self?.openForm()
            }
            self?.startView.isCreateButtonActive = true
        }
    }
}
