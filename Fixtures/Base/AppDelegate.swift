//
//  AppDelegate.swift
//  Fixtures
//
//  Created by Joe on 03/09/2018.
//  Copyright © 2018 InCrowd Sports. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = LaunchManager(window: &window).window
        return true
    }

}

