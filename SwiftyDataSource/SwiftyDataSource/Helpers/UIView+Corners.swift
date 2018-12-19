//
//  UIView+Corners.swift
//  HRketing
//
//  Created by Aleksey Bakhtin on 12/20/17.
//  Copyright © 2018 launchOptions. All rights reserved.
//

import UIKit

extension UIView {
    
    // Should be called after views layout
    func round(corners: UIRectCorner, byRadius value: CGFloat) {
        round(corners: corners, byRadii: CGSize(width: value, height: value))
    }

    func round(corners: UIRectCorner, byRadii value: CGSize) {
        let path = UIBezierPath(
            roundedRect: self.bounds,
            byRoundingCorners: corners,
            cornerRadii: value
        )
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}
