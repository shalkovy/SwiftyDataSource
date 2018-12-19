//
//  UIStackView+AddImageView.swift
//  HRketing
//
//  Created by Aleksey Bakhtin on 12/20/17.
//  Copyright © 2018 launchOptions. All rights reserved.
//

import UIKit

extension UIStackView {
    public func addImageViewArrangedSubview(_ imageView: UIImageView) {
        // Need to add ratio constraint to prevent stretching
        imageView.translatesAutoresizingMaskIntoConstraints = false
        if let image = imageView.image {
            let ratio = image.size.width / image.size.height
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: ratio).isActive = true
        }

        addArrangedSubview(imageView)
    }
}
