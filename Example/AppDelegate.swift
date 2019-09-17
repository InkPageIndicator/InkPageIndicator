//
//  AppDelegate.swift
//  Example
//
//  Created by Tyler on 2019. 9. 12..
//  Copyright © 2019 Tyler. All rights reserved.
//

import UIKit
import AssinLaunhcer
// MARK: - AppDelegate

/// The AppDelegate
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    /// The UIWindow
    var window: UIWindow?

    /// Application did finish launching with options
    ///
    /// - Parameters:
    ///   - application: The UIApplication
    ///   - launchOptions: The LaunchOptions
    /// - Returns: The launch result
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow()
               let launcherViewController = AssinLauncherViewController {
                window.rootViewController = DemoViewController.initFromStoryboard()
               }
               
               window.makeKeyAndVisible()
               window.backgroundColor = .white
               window.rootViewController = launcherViewController
               self.window = window
        return true
    }

}
