//
//  SelectablesListDelegate.swift
//  SwiftyDataSource
//
//  Created by Alexey Bakhtin on 27/08/2019.
//  Copyright © 2019 EffectiveSoft. All rights reserved.
//

import Foundation

public protocol SelectablesListDelegate {
    associatedtype T: SelectableEntity
    func listDidSelect(_ list: SelectablesListViewController<T>, _ entity: T)
    func listDidSelect(_ list: SelectablesListViewController<T>, entities: [T])
    func listDidDeselect(_ list: SelectablesListViewController<T>, _ entity: T)
}

public extension SelectablesListDelegate {
    func listDidSelect(_ list: SelectablesListViewController<T>, entities: [T]) { }
    func listDidDeselect(_ list: SelectablesListViewController<T>, _ entity: T) { }
}

public class AnySelectablesListDelegate<T>: SelectablesListDelegate where T: SelectableEntity {
    public required init<U: SelectablesListDelegate>(_ delegate: U) where U.T == T {
        _listDidSelectEntity = delegate.listDidSelect
        _listDidDeselectEntity = delegate.listDidDeselect
        _listDidSelectEntities = delegate.listDidSelect
    }
    
    private let _listDidSelectEntity: (SelectablesListViewController<T>, T) -> Void
    private let _listDidDeselectEntity: (SelectablesListViewController<T>, T) -> Void
    private let _listDidSelectEntities: (SelectablesListViewController<T>, [T]) -> Void
    
    public func listDidSelect(_ list: SelectablesListViewController<T>, _ entity: T) {
        return _listDidSelectEntity(list, entity)
    }
    public func listDidSelect(_ list: SelectablesListViewController<T>, entities: [T]) {
        return _listDidSelectEntities(list, entities)
    }
    public func listDidDeselect(_ list: SelectablesListViewController<T>, _ entity: T) {
        return _listDidDeselectEntity(list, entity)
    }
}
