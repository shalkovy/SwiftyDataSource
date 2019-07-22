//
//  String+onlyDigits.swift
//  launchOptions
//
//  Created by Alexey Bakhtin on 10/1/18.
//  Copyright © 2018 launchOptions. All rights reserved.
//

import Foundation

public extension String {
    var digitsOnly: String {
        return components(separatedBy: NSCharacterSet.decimalDigits.inverted).joined(separator: "")
    }

    var decimalString: String {
        let filteredString = components(separatedBy: CharacterSet(charactersIn: "01234567890.,").inverted).joined(separator: "")
        let decimalComponents = filteredString.components(separatedBy: CharacterSet(charactersIn: ".,"))
        var result: String
        if decimalComponents.count > 1, let last = decimalComponents.last {
            result = decimalComponents.dropLast().joined()
                .appending(NumberFormatter().decimalSeparator)
                .appending(last)
        } else {
            result = decimalComponents.joined()
        }
        return result
    }
}

