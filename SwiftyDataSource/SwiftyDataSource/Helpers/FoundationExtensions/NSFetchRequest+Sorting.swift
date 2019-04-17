//
//  NSManagedObject+FetchRequest.swift
//  DPDataStorage
//
//  Created by Alexey Bakhtin on 12/18/17.
//  Copyright © 2017 launchOptions. All rights reserved.
//

import Foundation
import CoreData

public extension NSFetchRequest {
    
    @objc
    func sorted(by descriptors: [NSSortDescriptor]) -> Self {
        self.sortDescriptors = descriptors
        return self
    }
    
}
