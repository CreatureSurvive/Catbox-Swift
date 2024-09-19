//
//  CatboxURLUploadRequest.swift
//
//
//  Created by Dana Buehre on 9/19/24.
//

import Foundation

/// Upload request for a file at a remote URL
///
/// Must use a remote file URL, local URLs will throw `localUrlNotSupported` error during processing of the request
public struct CatboxURLUploadRequest {
    let requestType = "urlupload"
    let userhash: String?
    let url: URL
    
    public init(userhash: String?, url: URL) {
        self.userhash = userhash
        self.url = url
    }
}
