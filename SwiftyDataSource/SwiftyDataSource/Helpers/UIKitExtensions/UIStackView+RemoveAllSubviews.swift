//
//  UIStackView+RemoveAllSubviews.swift
//  launchOptions
//
//  Created by Alexey Bakhtin on 10/8/18.
//  Copyright © 2018 launchOptions. All rights reserved.
//

import UIKit

public extension UIStackView {
    func removeAllSubviews() {
        let removedSubviews = arrangedSubviews.reduce([]) { (allSubviews, subview) -> [UIView] in
            self.removeArrangedSubview(subview)
            return allSubviews + [subview]
        }
        NSLayoutConstraint.deactivate(removedSubviews.flatMap({ $0.constraints }))
        removedSubviews.forEach({ $0.removeFromSuperview() })
    }
}
