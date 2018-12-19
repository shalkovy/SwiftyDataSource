//
//  UIButton+Background.swift
//  Proscope
//
//  Created by Alexey Bakhtin on 9/30/18.
//  Copyright © 2018 launchOptions. All rights reserved.
//

import UIKit
import Foundation

extension UIButton {
    @IBInspectable
    var normalBackgroundColor: UIColor? {
        set {
            setBackgroundColor(color: newValue, forUIControlState: .normal)
        }
        get {
            return nil
        }
    }
    
    @IBInspectable
    var highlightedBackgroundColor: UIColor? {
        set {
            let newColor = newValue?.withAlphaComponent(0.5)
            setBackgroundColor(color: newColor, forUIControlState: .highlighted)
        }
        get {
            return nil
        }
    }

    @IBInspectable
    var selectedBackgroundColor: UIColor? {
        set {
            setBackgroundColor(color: newValue, forUIControlState: .selected)
        }
        get {
            return nil
        }
    }

    func setBackgroundColor(color: UIColor?, forUIControlState state: UIControl.State) {
        guard let color = color else {
            setBackgroundImage(nil, for: state)
            return
        }
        self.setBackgroundImage(image(withColor: color), for: state)
    }
    
    private func image(withColor color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()!
        context.setFillColor(color.cgColor)
        context.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
}
