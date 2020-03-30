//
//  UIDocumentInteractionControllerPresenter.swift
//  SwiftyDataSource
//
//  Created by Alexey Bakhtin on 03/09/2019.
//  Copyright © 2019 EffectiveSoft. All rights reserved.
//

import UIKit

public class UIDocumentInteractionControllerPresenter: NSObject, UIDocumentInteractionControllerDelegate {
    
    private static let defaultPresenter = UIDocumentInteractionControllerPresenter()
    
    public static func showDocumentInteractionController(for url: URL, from viewController: UIViewController) {
        defaultPresenter.viewControllerForPreview = viewController
        defaultPresenter.documentInteractionController.url = url
        defaultPresenter.documentInteractionController.presentPreview(animated: true)
    }
    
    private lazy var documentInteractionController: UIDocumentInteractionController = {
        let controller = UIDocumentInteractionController()
        controller.delegate = self
        return controller
    }()
    
    private weak var viewControllerForPreview: UIViewController!
    
    public func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        return viewControllerForPreview
    }
}
