//
//  NSManagedObject+FetchRequest.swift
//  DPDataStorage
//
//  Created by Alex on 12/18/17.
//  Copyright © 2017 EffectiveSoft. All rights reserved.
//

import Foundation
import CoreData

extension NSFetchRequest {
    
    @objc public func sorted(by descriptors: [NSSortDescriptor]) -> Self {
        self.sortDescriptors = descriptors
        return self
    }
    
    
}
