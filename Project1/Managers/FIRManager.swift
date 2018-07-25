//
//  FIRManager.swift
//  Project1
//
//  Created by Thanh Quach on 7/25/18.
//  Copyright © 2018 TRUONGVU. All rights reserved.
//

import Foundation
import FirebaseDatabase

class FIRManager {

    static let shared: FIRManager = FIRManager()

    let ref: DatabaseReference
    var userRef: DatabaseReference {
        return ref.child("users")
    }

    private init() {
        ref = Database.database().reference().child("hellofirebaseapp")
    }

}
