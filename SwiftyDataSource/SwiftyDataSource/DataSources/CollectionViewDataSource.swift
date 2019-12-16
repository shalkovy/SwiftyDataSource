//
//  CollectionViewDataSource.swift
//  DPDataStorage
//
//  Created by Alexey Bakhtin on 12/19/17.
//  Copyright © 2018 launchOptions. All rights reserved.
//

import UIKit

open class CollectionViewDataSource<ObjectType>: NSObject, DataSource, UICollectionViewDataSource, UICollectionViewDelegate {
    
    // MARK: Initializer
    
    public init(collectionView: UICollectionView? = nil,
                container: DataSourceContainer<ObjectType>? = nil,
                delegate: AnyCollectionViewDataSourceDelegate<ObjectType>? = nil,
                cellIdentifier: String? = nil) {
        self.collectionView = collectionView
        self.delegate = delegate
        self.cellIdentifier = cellIdentifier
        self.container = container
        super.init()
        self.collectionView?.dataSource = self
        self.collectionView?.delegate = self
    }

    // MARK: Public properties
    
    public var container: DataSourceContainer<ObjectType>? {
        didSet {
            collectionView?.reloadData()
        }
    }

    public var collectionView: UICollectionView? {
        didSet {
            self.collectionView?.dataSource = self
            self.collectionView?.delegate = self
        }
    }
    
    public var cellIdentifier: String? {
        didSet {
            self.collectionView?.reloadData()
        }
    }
    
    public var delegate: AnyCollectionViewDataSourceDelegate<ObjectType>?

    // MARK: Implementing of datasource methods
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        guard let numberOfSections = numberOfSections else {
            return 0
        }
        return numberOfSections
    }

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let numberOfItems = numberOfItems(in: section) else {
            return 0
        }
        return numberOfItems
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let object = object(at: indexPath) else {
            fatalError("Could not retrieve object at \(indexPath)")
        }
        let cellIdentifier = delegate?.dataSource(self, cellIdentifierFor: object, at: indexPath) ?? self.cellIdentifier
        guard let identifier = cellIdentifier else {
            fatalError("Cell identifier is empty")
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) 
        guard let configurableCell = cell as? DataSourceConfigurable else {
            fatalError("Cell is not implementing DataSourceConfigurable protocol")
        }
        configurableCell.configure(with: object)
        return cell
    }
    
    // MARK: NoDataView processing
    
    public var noDataView: UIView?
    
    open func setNoDataView(hidden: Bool) {
        guard let _ = noDataView, let _ = collectionView else {
            return
        }
        fatalError("Not implemented")
    }

    public func invertExpanding(at indexPath: IndexPath) {
        fatalError("Not implemented")
    }
    
    // MARK: Selection
    
    open func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let object = object(at: indexPath) else { return }
        self.delegate?.dataSource(self, didSelect: object, at: indexPath)
    }
    open func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let object = object(at: indexPath) else { return }
        self.delegate?.dataSource(self, didSelect: object, at: indexPath)
    }
}

