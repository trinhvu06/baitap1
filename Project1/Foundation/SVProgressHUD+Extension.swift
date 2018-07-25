//
//  SVProgressHUD+Extension.swift
//  Project1
//
//  Created by Thanh Quach on 7/25/18.
//  Copyright © 2018 TRUONGVU. All rights reserved.
//

import Foundation
import SVProgressHUD

extension SVProgressHUD {

    static func vu_showError(_ text: String, duration: TimeInterval = 2, completion: (() -> ())? = nil) {
        SVProgressHUD.showError(withStatus: text)
        SVProgressHUD.dismiss(withDelay: duration) {
            completion?()
        }
    }

    static func vu_showSuccess(_ text: String, duration: TimeInterval = 2, completion: (() -> ())? = nil) {
        SVProgressHUD.showSuccess(withStatus: text)
        SVProgressHUD.dismiss(withDelay: duration) {
            completion?()
        }
    }

}
