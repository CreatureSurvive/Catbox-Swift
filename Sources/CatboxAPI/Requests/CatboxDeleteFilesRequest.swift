//
//  CatboxDeleteFilesRequest.swift
//
//
//  Created by Dana Buehre on 9/19/24.
//

import Foundation

/// Delete request for one or more files
///
/// Files should be the full file name including the extension eg: `ax5f01.jpeg`
public struct CatboxDeleteFilesRequest {
    let requestType = "deletefiles"
    let userhash: String
    let files: Set<String>
    
    public init(userhash: String, files: Set<String>) {
        self.userhash = userhash
        self.files = files
    }
}
