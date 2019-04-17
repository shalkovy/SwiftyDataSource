//
//  UIViewController+Childs.swift
//  launchOptions
//
//  Created by Alexey Bakhtin on 10/18/18.
//  Copyright © 2018 launchOptions. All rights reserved.
//

import UIKit

public extension UIViewController {
    func child<T: UIViewController>(of type: T.Type) -> T? {
        return self.children.filter { $0 is T }.last as? T
    }
}
