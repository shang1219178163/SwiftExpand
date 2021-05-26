//
//  AppDelegate.swift
//  SwiftExpandExample
//
//  Created by Bin Shang on 2019/12/11.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

import UIKit
import SwiftExpand

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let navController = UINavigationController(vcName: "HomeViewController")
        UIApplication.mainWindow.rootViewController = navController
        
        return true
    }

}

