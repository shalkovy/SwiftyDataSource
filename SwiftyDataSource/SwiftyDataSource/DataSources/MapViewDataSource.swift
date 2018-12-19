//
//  MapViewDataSource.swift
//  HRketing
//
//  Created by Aleksey Bakhtin on 12/20/17.
//  Copyright © 2018 launchOptions. All rights reserved.
//

import UIKit
import MapKit

class MapViewDataSource<ObjectType>: NSObject, DataSource, MKMapViewDelegate, DataSourceContainerDelegate where ObjectType: MKAnnotation {
    
    // MARK: Initializer
    
    public init(mapView: MKMapView?,
                annotationViewClass: AnyClass? = nil,
                container: DataSourceContainer<ObjectType>? = nil,
                delegate: AnyTableViewDataSourceDelegate<ObjectType>?) {
        self.container = container
        self.delegate = delegate
        self.mapView = mapView
        self.annotationViewClass = annotationViewClass
        super.init()
    }
    
    // MARK: Public properties

    public var mapView: MKMapView? {
        didSet {
            reloadAnnotations()
        }
    }

    public var annotationViewClass: AnyClass?
    public var delegate: AnyTableViewDataSourceDelegate<ObjectType>?

    // MARK: DataSource implementation
    
    var container: DataSourceContainer<ObjectType>? {
        didSet {
            container?.delegate = self
            reloadAnnotations()
        }
    }
    
    var noDataView: UIView?
    
    func setNoDataView(hidden: Bool) {
        fatalError()
    }
    
    func invertExpanding(at indexPath: IndexPath) {
        fatalError()
    }
    
    // MARK: Private
    
    private func reloadAnnotations() {
        guard let mapView = mapView,
            let container = container,
            annotationViewClass != nil else {
            return;
        }

        if let objects = container.fetchedObjects {
            mapView.addAnnotations(objects)
            mapView.showAnnotations(objects, animated: true)
        }
    }
    
    private func addAnnotation(_ annotation: MKAnnotation) {
        self.mapView?.addAnnotation(annotation)
    }

    private func removeAnnotation(_ annotation: MKAnnotation) {
        self.mapView?.removeAnnotation(annotation)
    }

    // MARK: Container delegate
    
    
    func containerWillChangeContent(_ container: DataSourceContainerProtocol) {
        
    }
    
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
