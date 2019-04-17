//
//  CheckBoxButton.swift
//  launchOptions
//
//  Created by Alexey Bakhtin on 10/2/18.
//  Copyright © 2018 launchOptions. All rights reserved.
//

import UIKit

public class CheckBoxButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        addTarget(self, action: #selector(action(_:)), for: UIControl.Event.touchUpInside)
    }
    
    @objc
    func action(_ sender: AnyObject) {
        self.isSelected = !self.isSelected
    }
    
}
