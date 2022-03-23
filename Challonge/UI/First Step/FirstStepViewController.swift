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
    }
    
    private var firstStepView: FirstStepView?
}
