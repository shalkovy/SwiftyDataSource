//
//  NSManagedObject+FetchRequest.swift
//  DPDataStorage
//
//  Created by Alexey Bakhtin on 12/18/17.
//  Copyright © 2018 launchOptions. All rights reserved.
//

import Foundation
import CoreData

extension NSFetchRequest {
    
    @objc
    public func sorted(by descriptors: [NSSortDescriptor]) -> Self {
        self.sortDescriptors = descriptors
        return self
    }
    
}
