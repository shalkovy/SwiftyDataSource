//
//  UIFont+Traits.swift
//  SwiftyDataSource
//
//  Created by Alexey Bakhtin  on 15/10/2019.
//  Copyright © 2019 launchOptions. All rights reserved.
//

import Foundation

public extension UIFont {
    func withTraights(_ traights: UIFontDescriptor.SymbolicTraits) -> UIFont {
        let newFontDescriptor = fontDescriptor.withSymbolicTraits(traights)!
        return UIFont(descriptor: newFontDescriptor, size: pointSize)
    }
}
