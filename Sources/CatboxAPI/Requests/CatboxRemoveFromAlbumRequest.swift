//
//  CatboxRemoveFromAlbumRequest.swift
//
//
//  Created by Dana Buehre on 9/19/24.
//

import Foundation

public struct CatboxRemoveFromAlbumRequest {
    let requestType = "removefromalbum"
    let userhash: String
    let album: String
    let files: Set<String>
    
    public init(userhash: String, album: String, files: Set<String>) {
        self.userhash = userhash
        self.album = album
        self.files = files
    }
}
