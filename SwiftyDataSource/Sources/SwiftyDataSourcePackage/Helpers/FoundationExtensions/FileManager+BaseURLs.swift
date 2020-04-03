//
//  FileManager.swift
//  SwiftyDataSource
//
//  Created by Alexey Bakhtin on 06/01/2020.
//  Copyright © 2020 launchOptions. All rights reserved.
//

import Foundation

public extension FileManager {
    func fileUrlInCachesDirectory(for response: HTTPURLResponse) -> URL {
        let cachesDirectoryURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
        return cachesDirectoryURL.appendingPathComponent(response.suggestedFilename!)
    }
    
    func fileUrlInCachesDirectory(for filename: String) -> URL {
        let documentsURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
        return documentsURL.appendingPathComponent(filename)
    }

    func fileUrlInDocumentsDirectory(for response: HTTPURLResponse) -> URL {
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return documentsURL.appendingPathComponent(response.suggestedFilename!)
    }

    func fileUrlInDocumentsDirectory(for filename: String) -> URL {
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return documentsURL.appendingPathComponent(filename)
    }

}
