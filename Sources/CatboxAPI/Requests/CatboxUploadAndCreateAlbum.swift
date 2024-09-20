//
//  CatboxUploadAndCreateAlbum.swift
//  
//
//  Created by Dana Buehre on 9/19/24.
//

import Foundation

public struct CatboxUploadAndCreateAlbum {
    let requestType = "createalbum"
    let userhash: String?
    let title: String
    let description: String
    let files: Set<URL>
    
    public init(userhash: String?, title: String, description: String, files: Set<URL>) {
        self.userhash = userhash
        self.title = title
        self.description = description
        self.files = files
    }
}
