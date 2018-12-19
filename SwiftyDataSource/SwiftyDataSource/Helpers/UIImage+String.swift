//
//  UIImage+String.swift
//  HRketing
//
//  Created by Aleksey Bakhtin on 12/20/17.
//  Copyright © 2018 launchOptions. All rights reserved.
//

import UIKit

public extension UIImage {
    public static func withText(_ text: String, font: UIFont = UIFont.systemFont(ofSize: 16), size: CGSize = CGSize(width: 45, height: 45)) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: size)
        let image = renderer.image { ctx in
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            let attrs = [NSAttributedString.Key.font: font, NSAttributedString.Key.paragraphStyle: paragraphStyle]
            let options = NSStringDrawingOptions.usesLineFragmentOrigin
            let mazSize = CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
            let textSize = text.boundingRect(with: mazSize, options: .usesLineFragmentOrigin, attributes: attrs, context: nil)
            let origin = CGPoint(x: 0, y: (size.height - textSize.height) / 2)
            text.draw(with: CGRect(origin: origin, size: size), options: options, attributes: attrs, context: nil)
        }
        return image
    }
}

