//
//  CatboxCreateAlbumRequest.swift
//  
//
//  Created by Dana Buehre on 9/19/24.
//

import Foundation

public struct CatboxCreateAlbumRequest {
    let requestType = "createalbum"
    let userhash: String?
    let title: String
    let description: String
    let files: Set<String>
    
    public init(userhash: String?, title: String, description: String, files: Set<String>) {
        self.userhash = userhash
        self.title = title
        self.description = description
        self.files = files
    }
}
