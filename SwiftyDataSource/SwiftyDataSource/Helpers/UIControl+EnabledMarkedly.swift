//
//  UIControl+EnabledMarkedly.swift
//  HRketing
//
//  Created by Aleksey Bakhtin on 12/20/17.
//  Copyright © 2018 launchOptions. All rights reserved.
//

import UIKit

public extension UIControl {
    public var isEnabledMarkedly: Bool {
        get {
            return isEnabled
        }
        set {
            alpha = newValue ? 1.0 : 0.5
            isEnabled = newValue
        }
    }
}
