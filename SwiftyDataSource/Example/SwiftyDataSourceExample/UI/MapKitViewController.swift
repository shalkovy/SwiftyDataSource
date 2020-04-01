//
//  MapKitViewController.swift
//  MapsDataSourceTest
//
//  Created by Dima Shelkov on 3/26/20.
//  Copyright © 2020 Dima Shelkov. All rights reserved.
//

import UIKit
import MapKit
import SwiftyDataSource

class MapKitViewController: UIViewController, MapViewDataSourceDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    let noDataView: NoDataView = NoDataView.fromNib()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    typealias ObjectType = TestMark
    
    private let dataContainer = ArrayDataSourceContainer<TestMark>()
    
    private lazy var dataSource: MapViewDataSource<TestMark> = {
        let dataSource = MapViewDataSource<TestMark>(mapView: mapView,
                                                     annotationViewClass: MKAnnotationView.self,
                                                     container: dataContainer,
                                                     delegate: AnyMapViewDataSourceDelegate(self))
        dataSource.noDataView = noDataView
        return dataSource
    }()
}
