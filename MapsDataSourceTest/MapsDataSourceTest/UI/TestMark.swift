//
//  TestMark.swift
//  MapsDataSourceTest
//
//  Created by Dima Shelkov on 3/27/20.
//  Copyright © 2020 Dima Shelkov. All rights reserved.
//

import UIKit
import MapKit

class TestMark: NSObject, MKAnnotation {
    let coordinate: CLLocationCoordinate2D
    var title: String?
    
    init(coordinate: CLLocationCoordinate2D, title: String) {
        self.coordinate = coordinate
        self.title = title
    }
}
