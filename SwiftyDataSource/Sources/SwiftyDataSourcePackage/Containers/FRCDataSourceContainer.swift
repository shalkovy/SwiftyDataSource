//
//  FRCDataSourceContainer.swift
//  DPDataStorage
//
//  Created by Alexey Bakhtin on 10/9/17.
//  Copyright © 2018 launchOptions. All rights reserved.
//

import UIKit
import CoreData

public class FRCDataSourceContainer<ResultType: NSFetchRequestResult>: DataSourceContainer<ResultType> {

    // MARK: Initializer
    
    public init(fetchRequest: NSFetchRequest<ResultType>,
                context: NSManagedObjectContext,
                sectionNameKeyPath: String? = nil,
                delegate: DataSourceContainerDelegate? = nil) {
        fetchedResultController =
            NSFetchedResultsController(fetchRequest: fetchRequest,
                                       managedObjectContext: context,
                                       sectionNameKeyPath: sectionNameKeyPath,
                                       cacheName: nil)
        delegateForwarder = CoreDataDelegateForwarder<ResultType>(delegate: delegate)
        super.init(delegate: delegate)
        fetchedResultController.delegate = delegateForwarder
        try! fetchedResultController.performFetch()
        delegateForwarder.container = self
    }

    // MARK: DataSourceContainer implementing

    open override var sections: [DataSourceSectionInfo]? {
        get {
            return fetchedResultController.sections
        }
    }
    
    open override var fetchedObjects: [ResultType]? {
        get {
            return fetchedResultController.fetchedObjects
        }
    }
    
    open override func object(at indexPath: IndexPath) -> ResultType? {
        return fetchedResultController.object(at: indexPath)
    }
    
    open override func search(_ block:(IndexPath, ResultType) -> Bool) {
        guard let sections = sections else { return }
        for (sectionIndex, section) in sections.enumerated() {
            if let sectionObjects = section.objects as? [ResultType] {
                for (rowIndex, object) in sectionObjects.enumerated() {
                    if block(IndexPath(row: rowIndex, section: sectionIndex), object) {
                        return
                    }
                }
            }
        }
    }

    open override func indexPath(for object: ResultType) -> IndexPath? {
        return fetchedResultController.indexPath(forObject: object)
    }
    
    open override func numberOfSections() -> Int {
        guard let sections = fetchedResultController.sections else {
            return 0
        }
        return sections.count
    }
    
    open override func numberOfItems(in section: Int) -> Int? {
        guard let sections = fetchedResultController.sections else {
            return 0
        }
        return sections[section].numberOfObjects
    }

    public override var delegate: DataSourceContainerDelegate? {
        didSet {
            delegateForwarder.delegate = delegate
        }
    }
    
    // MARK: Storage implementing
    
    fileprivate let fetchedResultController: NSFetchedResultsController<ResultType>
    fileprivate var delegateForwarder: CoreDataDelegateForwarder<ResultType>
}

class CoreDataDelegateForwarder<ResultType: NSFetchRequestResult>: NSObject, NSFetchedResultsControllerDelegate {
    
    weak var delegate: DataSourceContainerDelegate?
    weak var container: FRCDataSourceContainer<ResultType>?
    
    init(delegate: DataSourceContainerDelegate? = nil, container: FRCDataSourceContainer<ResultType>? = nil) {
        self.delegate = delegate
        self.container = container
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any,
                    at indexPath: IndexPath?,
                    for type: NSFetchedResultsChangeType,
                    newIndexPath: IndexPath?) {
        guard let container = container else { return }
        delegate?.container(container, didChange: anObject, at: indexPath, for: DataSourceObjectChangeType.fromFRCChangeType(type), newIndexPath: newIndexPath)
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange sectionInfo: NSFetchedResultsSectionInfo,
                    atSectionIndex sectionIndex: Int,
                    for type: NSFetchedResultsChangeType) {
        guard let container = container else { return }
        delegate?.container(container, didChange: sectionInfo, atSectionIndex: sectionIndex, for: DataSourceObjectChangeType.fromFRCChangeType(type))
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        guard let container = container else { return }
        delegate?.containerWillChangeContent(container)
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        guard let container = container else { return }
        delegate?.containerDidChangeContent(container)
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    sectionIndexTitleForSectionName sectionName: String) -> String? {
        guard let container = container else { return nil }
        return delegate?.container(container, sectionIndexTitleForSectionName: sectionName)
    }
    
}
