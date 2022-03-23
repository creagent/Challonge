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
        openForm()
    }
    
    private var startView: StartView?
}

private extension StartViewController {
    func openForm() {
        let vc = FirstStepViewController()
        let navVC = UINavigationController()
        navVC.viewControllers = [vc]
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true)
    }
}

class CustomNavigationController: UINavigationController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
        setNavigationBarHidden(true, animated: false)
    }
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        setNavigationBarHidden(true, animated: false)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
