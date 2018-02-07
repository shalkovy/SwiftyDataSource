//
//  SwiftyDataSourceTests.swift
//  SwiftyDataSourceTests
//
//  Created by Aleksey Bakhtin on 2/2/18.
//  Copyright © 2018 EffectiveSoft. All rights reserved.
//

import XCTest
@testable import SwiftyDataSource

class SwiftyDataSourceTests: XCTestCase {
    
    var dataSourceContainer: ArrayDataSourceContainer<Int>!
    
    override func setUp() {
        super.setUp()
        dataSourceContainer = ArrayDataSourceContainer(objects: nil, named: "", delegate: nil)
    }
    
    override func tearDown() {
        dataSourceContainer = nil
        super.tearDown()
    }
    
    func testNumberOfItems() {
        // 1. given
        try! dataSourceContainer.insert(object: 0, at: IndexPath(row: 0, section: 0))
        // 3. then
        XCTAssertEqual(dataSourceContainer.numberOfSections(), 1)
        XCTAssertEqual(dataSourceContainer.numberOfItems(in: 0), 1)
        XCTAssertEqual(dataSourceContainer.numberOfItems(in: 1), 0)
    }

    func testRemoveAll() {
        // 1. given
        try! dataSourceContainer.insert(object: 0, at: IndexPath(row: 0, section: 0))
        // 2. when
        dataSourceContainer.removeAll()
        // 3. then
        XCTAssertEqual(dataSourceContainer.numberOfSections(), 0)
    }
    
    func testInsertFirst() {
        // 1. given
        dataSourceContainer.removeAll()
        // 2. when
        let object = 1
        let indexPath = IndexPath(row: 0, section: 0)
        try! dataSourceContainer.insert(object: object, at: indexPath)
        let firstFetchedObject = dataSourceContainer.object(at: indexPath)
        // 3. then
        XCTAssertEqual(object, firstFetchedObject)
        // 2. when
        let secondSectionIndexPath = IndexPath(row: 0, section: 1)
        try!dataSourceContainer.insert(object: object, at: secondSectionIndexPath)
        let secondFetchedObject = dataSourceContainer.object(at: secondSectionIndexPath)
        // 3. then
        XCTAssertEqual(object, secondFetchedObject)
    }

    func testInsertAfterEmpty() {
        // 1. given
        dataSourceContainer.removeAll()
        let secondItemIndexPath = IndexPath(row: 1, section: 0)
        // 3. then
        XCTAssertThrowsError(try dataSourceContainer.insert(object: 0, at: secondItemIndexPath))
        // 1. given
        dataSourceContainer.removeAll()
        let secondSectionItemIndexPath = IndexPath(row: 0, section: 1)
        // 3. then
        XCTAssertThrowsError(try dataSourceContainer.insert(object: 0, at: secondSectionItemIndexPath))
    }
}

extension SwiftyDataSourceTests: DataSourceContainerDelegate {
    
    func containerWillChangeContent(_ container: DataSourceContainerProtocol) { }
    
    func container(_ container: DataSourceContainerProtocol, didChange anObject: Any, at indexPath: IndexPath?, for type: DataSourceObjectChangeType, newIndexPath: IndexPath?) {
        
    }
    
    func container(_ container: DataSourceContainerProtocol, didChange sectionInfo: DataSourceSectionInfo, atSectionIndex sectionIndex: Int, for type: DataSourceObjectChangeType) {
        
    }
    
    func container(_ container: DataSourceContainerProtocol, sectionIndexTitleForSectionName sectionName: String) -> String? {
        return nil
    }
    
    func containerDidChangeContent(_ container: DataSourceContainerProtocol) {
        
    }
}
