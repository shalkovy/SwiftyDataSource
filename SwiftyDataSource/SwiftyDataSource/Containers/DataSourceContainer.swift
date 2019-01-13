//
//  DataSourceContainer.swift
//  DPDataStorage
//
//  Created by Alexey Bakhtin on 10/6/17.
//  Copyright © 2018 launchOptions. All rights reserved.
//

import Foundation
import CoreData

public typealias DataSourceSectionInfo = NSFetchedResultsSectionInfo
public typealias DataSourceObjectChangeType = NSFetchedResultsChangeType

public protocol DataSourceContainerProtocol { }

public class DataSourceContainer<ResultType>: DataSourceContainerProtocol {
    
    // MARK: Initializer
    
    init(delegate: DataSourceContainerDelegate? = nil) {
        self.delegate = delegate
    }

    // MARK: Delegate

    public var delegate: DataSourceContainerDelegate?

    // MARK: Methods for overriding in subclasses
    
    open var sections: [DataSourceSectionInfo]? {
        get {
            assertionFailure("Should be overriden in subclasses")
            return nil
        }
    }
    
    open var fetchedObjects: [ResultType]? {
        get {
            assertionFailure("Should be overriden in subclasses")
            return nil
        }
    }

    open var hasData: Bool {
        get {
            if let fetchedObjects = fetchedObjects {
                return fetchedObjects.count > 0
            }
            return false
        }
    }

    open func object(at indexPath: IndexPath) -> ResultType? {
        assertionFailure("Should be overriden in subclasses")
        return nil
    }
    
    open func indexPath(for object: ResultType) -> IndexPath? {
        assertionFailure("Should be overriden in subclasses")
        return nil
    }

    open func numberOfSections() -> Int? {
        assertionFailure("Should be overriden in subclasses")
        return nil
    }
    
    open func numberOfItems(in section: Int) -> Int? {
        assertionFailure("Should be overriden in subclasses")
        return nil
    }
}

// MARK: DataSourceContainerDelegate

public protocol DataSourceContainerDelegate {
    
    // MARK: - Optional

    func containerWillChangeContent(_ container: DataSourceContainerProtocol)
    
    func container(_ container: DataSourceContainerProtocol,
                   didChange anObject: Any,
                   at indexPath: IndexPath?,
                   for type: DataSourceObjectChangeType,
                   newIndexPath: IndexPath?)
    
    func container(_ container: DataSourceContainerProtocol,
                   didChange sectionInfo: DataSourceSectionInfo,
                   atSectionIndex sectionIndex: Int,
                   for type: DataSourceObjectChangeType)
    
    func container(_ container: DataSourceContainerProtocol,
                   sectionIndexTitleForSectionName sectionName: String) -> String?
    
    // MARK: - Required
    
    func containerDidChangeContent(_ container: DataSourceContainerProtocol)

}

public extension DataSourceContainerDelegate {
    func containerWillChangeContent(_ container: DataSourceContainerProtocol) { }
    
    func container(_ container: DataSourceContainerProtocol,
                   didChange anObject: Any,
                   at indexPath: IndexPath?,
                   for type: DataSourceObjectChangeType,
                   newIndexPath: IndexPath?) { }
    
    func container(_ container: DataSourceContainerProtocol,
                   didChange sectionInfo: DataSourceSectionInfo,
                   atSectionIndex sectionIndex: Int,
                   for type: DataSourceObjectChangeType) { }
    
    func container(_ container: DataSourceContainerProtocol,
                   sectionIndexTitleForSectionName sectionName: String) -> String? { return nil }

}
