//
//  CatboxLocalURLUploadRequest.swift
//
//
//  Created by Dana Buehre on 9/19/24.
//

import Foundation

/// Upload request for a file at a local file URL
///
/// Must use a local file URL, remote URLs will throw `localUrlNotSupported` error during processing of the request
public struct CatboxLocalURLUploadRequest {
    let requestType = "fileupload"
    let userhash: String?
    let url: URL
    
    public init(userhash: String?, url: URL) {
        self.userhash = userhash
        self.url = url
    }
}
