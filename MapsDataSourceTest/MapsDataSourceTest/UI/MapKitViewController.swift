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
    let testMark = TestMark(coordinate: CLLocationCoordinate2D(latitude: 53.53, longitude: 27.34), title: "Test Mark")
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        dataContainer.add(sectionObjects: [testMark])
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
