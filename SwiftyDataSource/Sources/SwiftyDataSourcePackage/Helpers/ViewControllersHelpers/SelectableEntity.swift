//
//  SelectableEntity.swift
//  SwiftyDataSource
//
//  Created by Alexey Bakhtin on 27/08/2019.
//  Copyright © 2019 EffectiveSoft. All rights reserved.
//

import Foundation

public protocol SelectableEntity {
    var selectableEntityDescription: NSAttributedString { get }
    func selectableEntityIsEqual(to: SelectableEntity) -> Bool
}

extension String: SelectableEntity {
    public var selectableEntityDescription: NSAttributedString {
        return NSAttributedString(string: self)
    }
    
    public func selectableEntityIsEqual(to: SelectableEntity) -> Bool {
        return self == to as? String
    }
}
