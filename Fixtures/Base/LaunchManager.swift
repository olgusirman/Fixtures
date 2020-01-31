//
//  LaunchManager.swift
//  Fixtures
//
//  Created by Olgu on 31.01.2020.
//  Copyright © 2020 InCrowd Sports. All rights reserved.
//

import UIKit

final class LaunchManager {
    
    var window: UIWindow?
    
    required init(window: inout UIWindow?) {
        self.window = window
        self.window = UIWindow(frame: UIScreen.main.bounds)
        prepareWindow()
    }
    
    private func prepareWindow() {
        self.window?.rootViewController = prepareRootController()
        self.window?.makeKeyAndVisible()
    }
    
    private func prepareRootController() -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: prepareFixturesController())
        // According to guideline first pages navigationTitle should be large
        navigationController.navigationBar.prefersLargeTitles = true
        return navigationController
    }
    
    private func prepareFixturesController() -> FixturesViewController {
        var fixturesVC = FixturesViewController.instantiate()
        fixturesVC.bind(to: FixturesViewModel())
        return fixturesVC
    }
}
