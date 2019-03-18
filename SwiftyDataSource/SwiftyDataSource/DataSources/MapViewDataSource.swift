//
//  MapViewDataSource.swift
//  HRketing
//
//  Created by Aleksey Bakhtin on 12/20/17.
//  Copyright © 2018 launchOptions. All rights reserved.
//

import UIKit
import MapKit

public protocol IMapView {
    func addAnnotations(for objects: [MKAnnotation])
    func showAnnotations(_ objects: [MKAnnotation], animated: Bool)
}

open class MapViewDataSource<ObjectType>: NSObject, DataSource, MKMapViewDelegate, DataSourceContainerDelegate where ObjectType: MKAnnotation {
    
    // MARK: Initializer
    
    public init(mapView: IMapView? = nil,
                annotationViewClass: AnyClass? = nil,
                container: DataSourceContainer<ObjectType>? = nil,
                delegate: AnyMapViewDataSourceDelegate<ObjectType>? = nil) {
        self.container = container
        self.delegate = delegate
        self.mapView = mapView
        self.annotationViewClass = annotationViewClass
        super.init()
    }
    
    // MARK: Public properties

    public var mapView: IMapView? {
        didSet {
//            mapView?.delegate = self
            reloadAnnotations()
        }
    }

    public var annotationViewClass: AnyClass?
    public var delegate: AnyMapViewDataSourceDelegate<ObjectType>?

    open func showAnnotations(_ objects: [ObjectType]) {
        mapView?.showAnnotations(objects, animated: true)
    }
    
    open func addAnnotations(_ objects: [ObjectType]) {
        mapView?.addAnnotations(for: objects)
    }

    // MARK: DataSource implementation
    
    public var container: DataSourceContainer<ObjectType>? {
        didSet {
            container?.delegate = self
            reloadAnnotations()
        }
    }
    
    public var noDataView: UIView?
    
    public func setNoDataView(hidden: Bool) {
        fatalError()
    }
    
    public func invertExpanding(at indexPath: IndexPath) {
        fatalError()
    }
    
    // MARK: Private
    
    private func reloadAnnotations() {
        guard mapView != nil,
            let container = container,
            annotationViewClass != nil else {
            return;
        }

        if let objects = container.fetchedObjects {
            addAnnotations(objects)
            showAnnotations(objects)
        }
    }
    
//    private func addAnnotation(_ annotation: MKAnnotation) {
//        self.mapView?.addAnnotation(annotation)
//    }
//
//    private func removeAnnotation(_ annotation: MKAnnotation) {
//        self.mapView?.removeAnnotation(annotation)
//    }

    // MARK: Container delegate
    
    
    open func containerWillChangeContent(_ container: DataSourceContainerProtocol) {
        
    }
    
    open func container(_ container: DataSourceContainerProtocol, didChange anObject: Any, at indexPath: IndexPath?, for type: DataSourceObjectChangeType, newIndexPath: IndexPath?) {
        
    }
    
    open func container(_ container: DataSourceContainerProtocol, didChange sectionInfo: DataSourceSectionInfo, atSectionIndex sectionIndex: Int, for type: DataSourceObjectChangeType) {
        
    }
    
    open func container(_ container: DataSourceContainerProtocol, sectionIndexTitleForSectionName sectionName: String) -> String? {
        return nil
    }
    
    open func containerDidChangeContent(_ container: DataSourceContainerProtocol) {
        
    }
    
    // MARK: MKMapViewDelegate
    
    public func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        guard let annotation = view.annotation as? ObjectType else { return }
        delegate?.dataSource(self, didSelect: annotation)
    }

}
