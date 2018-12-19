//
//  NoDataView+Text.swift
//  HRketing
//
//  Created by Aleksey Bakhtin on 12/20/17.
//  Copyright © 2018 launchOptions. All rights reserved.
//

import Foundation
import UIKit

extension DataSource {
    
    public var noDataViewText: String? {
        get {
            return noDataViewAsLabel?.text
        }
        set {
            let noDataView = UILabel()
            noDataView.textColor = UIColor(red: 56.0 / 255.0, green: 70.0 / 255.0, blue: 80.0 / 255.0, alpha: 1.0)
            noDataView.numberOfLines = 0
            noDataView.textAlignment = .center
            noDataViewAsLabel = noDataView

            noDataViewAsLabel?.text = newValue
        }
    }
    
    private var noDataViewAsLabel: UILabel? {
        get {
            return noDataView as? UILabel
        }
        set {
            noDataView = newValue
        }
    }

}
