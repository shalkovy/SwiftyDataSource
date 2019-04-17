//
//  UIControl+EnabledMarkedly.swift
//  launchOptions
//
//  Created by Alexey Bakhtin on 10/9/18.
//  Copyright © 2018 launchOptions. All rights reserved.
//

import UIKit

public extension UIControl {
    var isEnabledMarkedly: Bool {
        get {
            return isEnabled
        }
        set {
            alpha = newValue ? 1.0 : 0.5
            isEnabled = newValue
        }
    }
}
