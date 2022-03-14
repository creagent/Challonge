//
//  AppDelegate.swift
//  Challonge
//
//  Created by Антон Алексеев on 13.03.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let homeViewController = ViewController()
        window?.backgroundColor = .white
        window!.rootViewController = homeViewController
        window!.makeKeyAndVisible()
        return true
    }
}

