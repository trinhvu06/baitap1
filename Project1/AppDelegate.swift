//
//  AppDelegate.swift
//  Project1
//
//  Created by trinh truong vu on 7/16/18.
//  Copyright © 2018 TRUONGVU. All rights reserved.
//

import UIKit
import Firebase
import FBSDKCoreKit
import GoogleSignIn
import FBSDKLoginKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)

        let window = UIWindow(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        if UserManager.share.getCurrenUser() == nil {
            // Hien thi man hinh login
            let loginViewController = SignInViewController()
            window.rootViewController = loginViewController
        } else {
            // Hien thi man hinh da login
            let mainTabBarController = MainTabBarController()
            window.rootViewController = mainTabBarController
        }

        self.window = window
        window.makeKeyAndVisible()

        return true
    }

    @available(iOS 9.0, *)
    func application(_ application: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any])
        -> Bool {
            return GIDSignIn.sharedInstance().handle(url,
                                                     sourceApplication:options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String,
                                                     annotation: [:]) || FBSDKApplicationDelegate.sharedInstance().application(application, open: url, options: options)
    }


}

