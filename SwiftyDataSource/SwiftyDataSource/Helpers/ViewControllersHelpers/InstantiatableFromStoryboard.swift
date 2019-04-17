//
//  InstantiatableFromStoryboard.swift
//  launchOptions
//
//  Created by Alexey Bakhtin on 10/1/18.
//  Copyright © 2018 launchOptions. All rights reserved.
//

import UIKit

public protocol InstantiatableFromStoryboard {
    static func defaultContainingStoryboard() -> UIStoryboard
    static func storyboardIdentifier() -> String
}

public extension InstantiatableFromStoryboard {
    static func defaultContainingStoryboard() -> UIStoryboard {
        return UIStoryboard(name: String(describing: self), bundle: nil)
    }
    
    static func storyboardIdentifier() -> String {
        return String(describing: self)
    }
}

public extension UIStoryboard {
    class func instantiate<T: InstantiatableFromStoryboard>(viewControllerOf type: T.Type) -> T {
        return T.defaultContainingStoryboard().instantiate(viewControllerOf: type)
    }
    
    func instantiate<T: InstantiatableFromStoryboard>(viewControllerOf type: T.Type) -> T {
        let instance = self.instantiateViewController(withIdentifier: T.storyboardIdentifier())
        guard let typedInstance = instance as? T else {
            fatalError("Could not cast instantiated value to expected type")
        }
        return typedInstance
    }
}

public extension UINib {
    static func instantiate<T>(objectOf type: T.Type,
                                      nibName: String? = nil,
                                      bundle: Bundle? = nil,
                                      owner: AnyObject? = nil,
                                      options: [UINib.OptionsKey : Any]? = nil) -> T {
        let nibNameOrDefaul = nibName ?? String(describing: type)
        let allObjects = self.init(nibName: nibNameOrDefaul, bundle:bundle).instantiate(withOwner: owner, options:options)
        let resultObjects = allObjects.filter { $0 is T }
        guard let resultObject = resultObjects.last as? T else {
            fatalError("Could not cast instantiated value to expected type")
        }
        return resultObject
    }
}
