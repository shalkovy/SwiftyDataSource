//
//  UITableViewCell+Position.swift
//  launchOptions
//
//  Created by Alexey Bakhtin on 06/09/2018.
//  Copyright © 2018 launchOptions. All rights reserved.
//

import UIKit

public extension UITableViewCell {
    enum Position {
        case first
        case middle
        case last
        case onlyOne
    }
}

public extension TableViewDataSource {

    func position(of indexPath: IndexPath) -> UITableViewCell.Position? {
        guard let rowsCount = numberOfItems(in: indexPath.section) else {
            return nil
        }
        
        var position: UITableViewCell.Position
        if rowsCount == 1 {
            position = .onlyOne
        } else if indexPath.row == 0 {
            position = .first
        } else if indexPath.row == rowsCount - 1 {
            position = .last
        } else {
            position = .middle
        }
        return position
    }

}
