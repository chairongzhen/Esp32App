//
//  AppDelegate.swift
//  ppLedc
//
//  Created by 柴荣臻 on 2019/7/12.
//  Copyright © 2019 rzchai. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        UITabBar.appearance().tintColor = 	UIColor.orange
        
        let userinfo = UserDefaults.standard
        let username: Any? = userinfo.object(forKey: "username")
        if let username = username {
            print(userinfo.object(forKey: "openid"))
        } else {
            self.window?.rootViewController = UINavigationController(rootViewController: LoginViewController())
        }
        return true
    }
}

