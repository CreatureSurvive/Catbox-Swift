//
//  CatboxFilesUploadRequest.swift
//
//
//  Created by Dana Buehre on 9/19/24.
//

import Foundation

/// Upload request for  a list of files
///
/// The request can contain local URLs, remote URLs, or a mix of both.
public struct CatboxFilesUploadRequest {
    let requestType = "fileupload"
    let userhash: String?
    let files: Set<URL>
    
    public init(userhash: String?, files: Set<URL>) {
        self.userhash = userhash
        self.files = files
    }
}
