//
//  UIManager.swift
//  Project1
//
//  Created by Thanh Quach on 7/25/18.
//  Copyright © 2018 TRUONGVU. All rights reserved.
//

import Foundation
import UIKit

class UIManager {

    static func goToAuthenticatedController() {
        let mainTabBarController = MainTabBarController()
        UIApplication.shared.keyWindow?.rootViewController = mainTabBarController
        UIApplication.shared.keyWindow?.makeKeyAndVisible()
    }

    static func goToAuthenticationController() {
        let vc = SignInViewController()
        UIApplication.shared.keyWindow?.rootViewController = vc
        UIApplication.shared.keyWindow?.makeKeyAndVisible()
    }

}
