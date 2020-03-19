//
//  AppDelegate.swift
//  NSAttributeStringTest
//
//  Created by d.yukimoto on 2020/03/10.
//  Copyright © 2020 tolv. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow()
        window.rootViewController = UINavigationController(rootViewController: SelectTestViewController())
        self.window = window
        window.makeKeyAndVisible()
        return true
    }
}

