//
//  AnyDataSource.swift
//  launchOptions
//
//  Created by Aleksey Bakhtin on 12/20/17.
//  Copyright © 2018 launchOptions. All rights reserved.
//

import UIKit

public class AnyDataSource<T>: DataSourceProtocol {
    
    var container: DataSourceContainer<T>? {
        get {
            return nil
        }
        set {
            
        }
    }
    var hasData: Bool {
        get {
            return false
        }
    }
    var numberOfSections: Int? {
        get {
            return nil
        }
    }
    var noDataView: UIView? {
        get {
            return nil
        }
        set {
            
        }
    }
    
    func numberOfItems(in section: Int) -> Int? {
        return nil
    }
    
    func object(at indexPath: IndexPath) -> T? {
        return nil
    }

    func showNoDataViewIfNeeded() {
        
    }
    
    func setNoDataView(hidden: Bool) {
        
    }
    
    func invertExpanding(at indexPath: IndexPath) {
        
    }
}
