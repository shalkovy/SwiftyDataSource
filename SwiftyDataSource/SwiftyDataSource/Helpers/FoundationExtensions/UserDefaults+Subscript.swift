//
//  UserDefaults+Subscript.swift
//  launchOptions
//
//  Created by Alexey Bakhtin on 10/10/18.
//  Copyright © 2018 launchOptions. All rights reserved.
//

import Foundation

extension UserDefaults {
    subscript<T>(key: String) -> T? {
        get {
            return value(forKey: key) as? T
        }
        set {
            set(newValue, forKey: key)
        }
    }
}
