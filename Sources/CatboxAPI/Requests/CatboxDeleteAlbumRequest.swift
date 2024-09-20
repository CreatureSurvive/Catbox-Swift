//
//  CatboxDeleteAlbumRequest.swift
//
//
//  Created by Dana Buehre on 9/19/24.
//

import Foundation

public struct CatboxDeleteAlbumRequest {
    let requestType = "deletealbum"
    let userhash: String
    let album: String
    
    public init(userhash: String, album: String) {
        self.userhash = userhash
        self.album = album
    }
}
