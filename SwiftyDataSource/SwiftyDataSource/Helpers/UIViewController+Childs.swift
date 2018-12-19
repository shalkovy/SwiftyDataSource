//
//  UIViewController+Childs.swift
//  HRketing
//
//  Created by Aleksey Bakhtin on 12/20/17.
//  Copyright © 2018 launchOptions. All rights reserved.
//

import UIKit

public extension UIViewController {
    public func child<T: UIViewController>(of type: T.Type) -> T? {
        return self.children.filter { $0 is T }.last as? T
    }
}
