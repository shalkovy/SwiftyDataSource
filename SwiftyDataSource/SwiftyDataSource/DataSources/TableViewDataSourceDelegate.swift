//
//  TableViewDataSourceDelegate.swift
//  launchOptions
//
//  Created by Aleksey Bakhtin on 12/20/17.
//  Copyright © 2018 launchOptions. All rights reserved.
//

import UIKit

// MARK: DataSource for customizing default behaviour of dataSource

public protocol TableViewDataSourceDelegate: class {
    associatedtype ObjectType
    func dataSource(_ dataSource: DataSourceProtocol, cellIdentifierFor object: ObjectType, at indexPath: IndexPath) -> String?
    func dataSource(_ dataSource: DataSourceProtocol, accessoryTypeFor object: ObjectType, at indexPath: IndexPath) -> UITableViewCell.AccessoryType?
    func dataSource(_ dataSource: DataSourceProtocol, didSelect object: ObjectType, at indexPath: IndexPath)
    func dataSource(_ dataSource: DataSourceProtocol, didDeselect object: ObjectType, at indexPath: IndexPath?)
}

// MARK: Default implementation as all of methods are optional

public extension TableViewDataSourceDelegate {
    func dataSource(_ dataSource: DataSourceProtocol, cellIdentifierFor object: ObjectType, at indexPath: IndexPath) -> String? {
        return nil
    }
    
    func dataSource(_ dataSource: DataSourceProtocol, accessoryTypeFor object: ObjectType, at indexPath: IndexPath) -> UITableViewCell.AccessoryType? {
        return nil
    }
    
    func dataSource(_ dataSource: DataSourceProtocol, didSelect object: ObjectType, at indexPath: IndexPath) { }
    func dataSource(_ dataSource: DataSourceProtocol, didDeselect object: ObjectType, at indexPath: IndexPath?) { }
}


// MARK: Type erasure for protocol with associated type. So we can use protocol for initializing

public class AnyTableViewDataSourceDelegate<T>: TableViewDataSourceDelegate {
    public required init<U: TableViewDataSourceDelegate>(_ delegate: U) where U.ObjectType == T {
        weak var weakDelegate = delegate
        _dataSourceCellIdentifierForObjectAtIndexPath = weakDelegate?.dataSource
        _dataSourceAccessoryTypeForObjectAtIndexPath = weakDelegate?.dataSource
        _dataSourceDidSelectObjectAtIndexPath = weakDelegate?.dataSource
        _dataSourceDidDeselectObjectAtIndexPath = weakDelegate?.dataSource
    }

    private let _dataSourceCellIdentifierForObjectAtIndexPath: ((DataSourceProtocol, T, IndexPath) -> String?)?
    private let _dataSourceAccessoryTypeForObjectAtIndexPath: ((DataSourceProtocol, T, IndexPath) -> UITableViewCell.AccessoryType?)?
    private let _dataSourceDidSelectObjectAtIndexPath: ((DataSourceProtocol, T, IndexPath) -> Void)?
    private let _dataSourceDidDeselectObjectAtIndexPath: ((DataSourceProtocol, T, IndexPath?) -> Void)?

    public func dataSource(_ dataSource: DataSourceProtocol, cellIdentifierFor object: T, at indexPath: IndexPath) -> String? {
        return _dataSourceCellIdentifierForObjectAtIndexPath?(dataSource, object, indexPath)
    }
    
    public func dataSource(_ dataSource: DataSourceProtocol, accessoryTypeFor object: T, at indexPath: IndexPath) -> UITableViewCell.AccessoryType? {
        return _dataSourceAccessoryTypeForObjectAtIndexPath?(dataSource, object, indexPath)
    }
    
    public func dataSource(_ dataSource: DataSourceProtocol, didSelect object: T, at indexPath: IndexPath) {
        return _dataSourceDidSelectObjectAtIndexPath?(dataSource, object, indexPath) ?? ()
    }

    public func dataSource(_ dataSource: DataSourceProtocol, didDeselect object: T, at indexPath: IndexPath?) {
        return _dataSourceDidDeselectObjectAtIndexPath?(dataSource, object, indexPath) ?? ()
    }

}
