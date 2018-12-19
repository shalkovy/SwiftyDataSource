//
//  Collection+SafeSubscript.swift
//  SwiftyDataSource
//
//  Created by Aleksey Bakhtin on 2/7/18.
//  Copyright © 2018 launchOptions. All rights reserved.
//

import Foundation

extension Collection {
    
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
    
}
