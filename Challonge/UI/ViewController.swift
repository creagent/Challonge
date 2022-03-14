//
//  ViewController.swift
//  Challonge
//
//  Created by Антон Алексеев on 13.03.2022.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        testView = TestView(ownerController: self)
    }
    
    private var testView: TestView?
}

