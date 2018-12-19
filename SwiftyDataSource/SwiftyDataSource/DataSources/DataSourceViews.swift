//
//  DataSourceViews.swift
//  HRketing
//
//  Created by Aleksey Bakhtin on 12/20/17.
//  Copyright © 2018 launchOptions. All rights reserved.
//

import UIKit

public class DataSourceCell<Type>: UITableViewCell {
    func configure(with object: Type) { }
}

public protocol DataSourceHeaderFooter {
    func configure(with object: DataSourceSectionInfo)
}

public class DataSourceCollectionCell<Type>: UICollectionViewCell {
    func configure(with object: Type) { }
}

public protocol DataSourcePositionHandler {
    func configure(for position: UITableViewCell.Position)
}

public protocol DataSourceExpandable {
    var expanded: Bool? { get set }
    var closedContraints: [NSLayoutConstraint]! { get }
    var expandedConstraints: [NSLayoutConstraint]! { get }
    mutating func setExpanded(value: Bool)
}

extension DataSourceExpandable {
    mutating func setExpanded(value: Bool) {
        expanded = value
    }
}
