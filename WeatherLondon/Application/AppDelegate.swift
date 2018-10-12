//
//  AppDelegate.swift
//  WeatherLondon
//
//  Created by Pablo Roca Rozas on 11/10/18.
//  Copyright © 2018 PR2Studio. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow()
        window?.backgroundColor = UIColor.pr2White

        let dependencies = DependencyContainer(navigationController: UINavigationController(), keyWindow: window!)

        appCoordinator = AppCoordinator(dependencies: dependencies)

        window?.rootViewController = appCoordinator!.start()
        window?.makeKeyAndVisible()

        // Override point for customization after application launch.
        return true
    }

}
