//
//  ArrayController.swift
//  DPDataStorage
//
//  Created by Aleksey Bakhtin on 12/20/17.
//  Copyright © 2017 EffectiveSoft. All rights reserved.
//

import UIKit

enum ArrayDataSourceContainerError: Error {
    case NonValidIndexPathInsertion
}

public class ArrayDataSourceContainer<ResultType: Equatable>: DataSourceContainer<ResultType> {

    // MARK: Initializer
    
    required public init(objects: [ResultType]?, named: String = "", delegate: DataSourceContainerDelegate?) {
        super.init(delegate: delegate)
        if let objects = objects {
            try! insert(sectionObjects: objects, at: 0, named: named, indexTitle: nil)
        }
    }

    // MARK: DataSourceContainer implementing
    
    open override var sections: [DataSourceSectionInfo]? {
        return arraySections
    }
    
    open override var fetchedObjects: [ResultType]? {
        get {
            return arraySections.reduce(into: [], { (result, section) in result?.append(contentsOf: section.arrayObjects) })
        }
    }
    
    open override func object(at indexPath: IndexPath) -> ResultType? {
//        guard let sections = arraySections else { return super.object(at: indexPath); }
        return arraySections[indexPath.section][indexPath.row]
    }
    
    open override func indexPath(for object: ResultType) -> IndexPath? {
//        guard let arraySections = arraySections else { return nil }
        for (sectionIndex, section) in arraySections.enumerated() {
            for (objectIndex, arrayObject) in section.arrayObjects.enumerated() {
                if (object == arrayObject) {
                    return IndexPath(row: objectIndex, section: sectionIndex)
                }
            }
        }
        
        return nil
    }
    
    open override func numberOfSections() -> Int? {
        return arraySections.count
    }
    
    open override func numberOfItems(in section: Int) -> Int? {
        guard section < arraySections.count else {
            return 0
        }
        return arraySections[section].arrayObjects.count
    }

    // MARK: Array controller public interface
    
    public func insert(object: ResultType, at indexPath: IndexPath) throws {
        let arraySection = arraySections[safe: indexPath.section]
        guard indexPath.row <= arraySection?.arrayObjects.count ?? 0 else {
            throw ArrayDataSourceContainerError.NonValidIndexPathInsertion
        }
        guard let section = arraySection else {
            try insert(sectionObjects: [object], at: indexPath.section)
            return
        }
        
        section.insert(object: object, at: indexPath.row)
    }

    public func insert(sectionObjects: [ResultType], at sectionIndex: Int = 0, named name: String = "", indexTitle: String? = nil) throws {
        guard sectionIndex <= self.arraySections.count else {
            throw ArrayDataSourceContainerError.NonValidIndexPathInsertion
        }
        let section = Section(objects: sectionObjects, name: name, indexTitle: indexTitle)
        self.arraySections.insert(section, at: sectionIndex)
    }
    
    public func removeAll() {
        arraySections.removeAll()
    }
    
    // MARK: Storage implementing
    
    var arraySections = [Section<ResultType>]()

    // MARK: Additional features

    public var sortDescritor: NSSortDescriptor? {
        didSet {
            // TODO:
        }
    }

    // MARK: Array section class
    
    class Section<ResultType>: DataSourceSectionInfo {
        
        // MARK: Initializing
        
        init(objects: [ResultType], name: String, indexTitle: String?) {
            self.arrayObjects = objects
            self.name = name
            self.indexTitle = indexTitle
        }
        
        // MARK: Storage
        
        private(set) var arrayObjects: [ResultType]
        
        // MARK: DataSourceSectionInfo implementing
        
        public var name: String
        
        public var indexTitle: String?
        
        var numberOfObjects: Int {
            guard let objects = objects else {
                return 0
            }
            return objects.count
        }
        
        public var objects: [Any]? {
            return arrayObjects
        }
        
        // MARK: Public interface
        
        func insert(object: ResultType, at index: Int) {
            self.arrayObjects.insert(object, at: index)
        }
        
        // MARK: Subscription
        
        subscript(index: Int) -> ResultType? {
            get {
                return arrayObjects[index]
            }
            set(newValue) {
                if let newValue = newValue {
                    arrayObjects[index] = newValue
                }
            }
        }
    }
}
