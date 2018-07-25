//
//  MainTabBarController.swift
//  Project1
//
//  Created by Thanh Quach on 7/25/18.
//  Copyright © 2018 TRUONGVU. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let friendViewController = FriendsViewController()
        friendViewController.tabBarItem = UITabBarItem(title: "Friends", image: nil, tag: 0)
        friendViewController.title = "Friends"
        let friendNav = friendViewController.embededNavigationController()

        let userProfileController = UserProfileViewController()
        userProfileController.tabBarItem = UITabBarItem(title: "User", image: nil, tag: 1)
        userProfileController.title = "Profile"
        let userProfileNav = userProfileController.embededNavigationController()

        self.viewControllers = [friendNav, userProfileNav]
    }

}
