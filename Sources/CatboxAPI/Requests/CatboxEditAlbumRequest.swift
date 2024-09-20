//
//  CatboxEditAlbumRequest.swift
//
//
//  Created by Dana Buehre on 9/19/24.
//

import Foundation

public struct CatboxEditAlbumRequest {
    let requestType = "editalbum"
    let userhash: String
    let album: String
    let title: String
    let description: String
    let files: Set<String>
    
    public init(userhash: String, album: String, title: String, description: String, files: Set<String>) {
        self.userhash = userhash
        self.album = album
        self.title = title
        self.description = description
        self.files = files
    }
}
