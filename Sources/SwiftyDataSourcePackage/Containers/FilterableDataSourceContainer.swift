//
//  FilterableDataSourceContainer.swift
//  SwiftyDataSource
//
//  Created by Alexey Bakhtin on 27/08/2019.
//  Copyright © 2019 EffectiveSoft. All rights reserved.
//

import Foundation

public class FilterableDataSourceContainer<T>: ArrayDataSourceContainer<T> where T: SelectableEntity {

    var filteredData: [[T]]?
    
    open func filterData(by searchText: String?) {
        filteredData = nil
        guard let searchText = searchText, searchText.count > 0 else { return }
        filteredData = [[T]]()
        arraySections.forEach {
            filteredData?.append($0.arrayObjects.filter { $0.selectableEntityDescription.string.lowercased().contains(searchText.lowercased()) } )
        }
    }

    open override func numberOfItems(in section: Int) -> Int? {
        if let filteredData = filteredData {
            return filteredData[section].count
        } else {
            return super.numberOfItems(in: section)
        }
    }

    open override func object(at indexPath: IndexPath) -> T? {
        if let filteredData = filteredData {
            return filteredData[indexPath.section][indexPath.row]
        } else {
            return super.object(at: indexPath)
        }
    }
}
