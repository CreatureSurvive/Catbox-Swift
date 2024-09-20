//
//  CatboxFileDataUploadRequest.swift
//
//
//  Created by Dana Buehre on 9/19/24.
//

import Foundation

/// Upload request for a single file using the files data
public struct CatboxFileDataUploadRequest {
    let requestType = "fileupload"
    let fileName: String
    let mimeType: String
    let userhash: String?
    let data: Data
    
    public init(fileName: String, mimeType: String, userhash: String?, data: Data) {
        self.fileName = fileName
        self.mimeType = mimeType
        self.userhash = userhash
        self.data = data
    }
}
