//
//  UserManager.swift
//  Project1
//
//  Created by trinh truong vu on 7/22/18.
//  Copyright © 2018 TRUONGVU. All rights reserved.
//

import Foundation
import FirebaseAuth

class UserManager{
    
    static let share: UserManager = UserManager()
    private init(){
        
    }
    public func getCurrenUser() -> User? {
        return Auth.auth().currentUser
    }
    
}

