//
//  UITableView+ReuseIdentifiers.swift
//  launchOptions
//
//  Created by Alexey Bakhtin on 10/1/18.
//  Copyright © 2018 launchOptions. All rights reserved.
//

import UIKit

public protocol IHaveDefaultReuseIdentifier {
     static var defaultReuseIdentifier: String { get }
}

public extension IHaveDefaultReuseIdentifier {
    static var defaultReuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: IHaveDefaultReuseIdentifier { }
extension UITableViewHeaderFooterView: IHaveDefaultReuseIdentifier { }

extension UICollectionReusableView: IHaveDefaultReuseIdentifier {}

public extension UICollectionView {
    func registerCellClassForDefaultIdentifier<T>(_ cellClass: T.Type) where T: UICollectionViewCell {
        register(cellClass, forCellWithReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    func registerCellNibForDefaultIdentifier<T>(_ cellClass: T.Type) where T: UITableViewCell {
        register(UINib(nibName: T.defaultReuseIdentifier, bundle: nil), forCellWithReuseIdentifier: T.defaultReuseIdentifier)
    }
}

public extension UITableView {
    func registerCellClassForDefaultIdentifier<T>(_ cellClass: T.Type) where T: UITableViewCell {
        register(cellClass, forCellReuseIdentifier: T.defaultReuseIdentifier)
    }

    func registerHeaderFooterClassForDefaultIdentifier<T>(_ viewClass: T.Type) where T: UITableViewHeaderFooterView {
        register(viewClass, forHeaderFooterViewReuseIdentifier: T.defaultReuseIdentifier)
    }

    func registerHeaderFooterNibForDefaultIdentifier<T>(_ viewClass: T.Type) where T: UITableViewHeaderFooterView {
        register(UINib.init(nibName: T.defaultReuseIdentifier, bundle: nil), forHeaderFooterViewReuseIdentifier: T.defaultReuseIdentifier)
    }


    func registerCellNibForDefaultIdentifier<T>(_ cellClass: T.Type) where T: UITableViewCell {
        register(UINib(nibName: T.defaultReuseIdentifier, bundle: nil), forCellReuseIdentifier: T.defaultReuseIdentifier)
    }
}

