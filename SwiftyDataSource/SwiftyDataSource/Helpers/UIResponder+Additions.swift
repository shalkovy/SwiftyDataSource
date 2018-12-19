//
//  UIResponder+Additions.swift
//  SwiftyDataSource
//
//  Created by Alex Bakhtin on 5/2/16.
//  Copyright © 2016 launchOptions. All rights reserved.
//

import UIKit

extension UIResponder {
    func nextViewControllerInResponderChain<T>() -> T? {
        var responder: UIResponder? = self
        while responder != nil {
            responder = responder!.next
            if let object = responder as? T {
                return object
            }
        }
        return nil
    }

    func objectOfClassInResponderChain<T>(_: T.Type) -> T? {
        var responder: UIResponder? = self
        while responder != nil && responder! is T == false {
            responder = responder!.next
        }
        return responder as? T
    }
}
