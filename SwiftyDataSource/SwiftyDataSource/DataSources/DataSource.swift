//
//  DataSource.swift
//  DPDataStorage
//
//  Created by Alexey Bakhtin on 10/19/17.
//  Copyright © 2018 launchOptions. All rights reserved.
//

import UIKit

public protocol DataSourceConfigurable {
    func configure(with object: Any)
}

public protocol DataSourceProtocol {
}

public protocol DataSource: DataSourceProtocol {
    associatedtype ObjectType
    
    var container: DataSourceContainer<ObjectType>? { get set }
    var hasData: Bool { get }
    var numberOfSections: Int? { get }
    var noDataView: UIView? { get set }

    func numberOfItems(in section: Int) -> Int?
    func object(at indexPath: IndexPath) -> ObjectType?
//    func indexPath(for object: ObjectType) -> IndexPath?
    func showNoDataViewIfNeeded()
    func setNoDataView(hidden: Bool)

    func invertExpanding(at indexPath: IndexPath)
}

extension DataSource {

    public var hasData: Bool {
        guard let container = container else { return false }
        return container.hasData
    }
    
    public var numberOfSections: Int? {
        return container?.numberOfSections()
    }
    
    public func numberOfItems(in section: Int) -> Int? {
        return container?.numberOfItems(in: section)
    }
    
    public func object(at indexPath: IndexPath) -> ObjectType? {
        return container?.object(at: indexPath)
    }
    
//    public func indexPath(for object: ObjectType) -> IndexPath? {
//        return container?.indexPath(for: object)
//    }

    public func sectionInfo(at index: Int) -> DataSourceSectionInfo? {
        return container?.sections?[index]
    }

    public func showNoDataViewIfNeeded() {
        setNoDataView(hidden: hasData)
    }

}
