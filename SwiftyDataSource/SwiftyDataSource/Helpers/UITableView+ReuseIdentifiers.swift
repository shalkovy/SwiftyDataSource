//
//  UITableView+ReuseIdentifiers.swift
//  HRketing
//
//  Created by Aleksey Bakhtin on 12/20/17.
//  Copyright © 2018 launchOptions. All rights reserved.
//

import UIKit

public extension UITableViewCell {
    public static var defaultReuseIdentifier: String {
        return String(describing: self)
    }
}

public extension UITableViewHeaderFooterView {
    public static var defaultReuseIdentifier: String {
        return String(describing: self)
    }
}

public extension UITableView {
    public func registerCellClassForDefaultIdentifier<T>(_ cellClass: T.Type) where T: UITableViewCell {
        register(cellClass, forCellReuseIdentifier: T.defaultReuseIdentifier)
    }

    public func registerHeaderFooterClassForDefaultIdentifier<T>(_ viewClass: T.Type) where T: UITableViewHeaderFooterView {
        register(viewClass, forHeaderFooterViewReuseIdentifier: T.defaultReuseIdentifier)
    }

    public func registerCellNibForDefaultIdentifier<T>(_ cellClass: T.Type) where T: UITableViewCell {
        register(UINib(nibName: T.defaultReuseIdentifier, bundle: nil), forCellReuseIdentifier: T.defaultReuseIdentifier)
    }

}
