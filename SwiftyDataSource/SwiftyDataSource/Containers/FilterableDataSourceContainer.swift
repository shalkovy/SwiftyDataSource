//
//  FilterableDataSourceContainer.swift
//  SwiftyDataSource
//
//  Created by Alexey Bakhtin on 27/08/2019.
//  Copyright © 2019 EffectiveSoft. All rights reserved.
//

import Foundation

public class FilterableDataSourceContainer<T>: ArrayDataSourceContainer<T> where T: SelectableEntity {

    open var searchText: String?

    open override func numberOfItems(in section: Int) -> Int? {
        if let searchText = searchText {
            return arraySections[section].arrayObjects.filter({ $0.selectableEntityDescription.string.contains(searchText) }).count
        } else {
            return super.numberOfItems(in: section)
        }
    }

    open override func object(at indexPath: IndexPath) -> T? {
        if let searchText = searchText {
            return arraySections[indexPath.section].arrayObjects.filter({ $0.selectableEntityDescription.string.contains(searchText) })[indexPath.row]
        } else {
            return super.object(at: indexPath)
        }
    }
}
