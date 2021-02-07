//
//  AppDelegate.swift
//  ArabamAssignment
//
//  Created by Furkan Arslan on 25.01.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow()
        window?.makeKeyAndVisible()
        let vehicleListController = VehicleListController()
        let navController = UINavigationController(rootViewController: vehicleListController)
        window?.rootViewController = navController
        return true
    }

}

