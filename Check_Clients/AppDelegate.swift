//
//  AppDelegate.swift
//  Check_Clients
//
//  Created by Станислав on 13.04.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let clientListVC = ClientListViewController()
        
        window?.rootViewController = clientListVC
        window?.makeKeyAndVisible()
        
        return true
    }
}
