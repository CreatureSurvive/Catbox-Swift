//
//  URL+MimeType.swift
//  
//
//  Created by Dana Buehre on 9/19/24.
//

import Foundation
import UniformTypeIdentifiers

internal extension URL {
    func mimeType() -> String {
        
        if let mimeType = try? self.resourceValues(forKeys: [.contentTypeKey]).contentType?.preferredMIMEType {
            return mimeType
        }
        else if let typeIdentifier = try? self.resourceValues(forKeys: [.typeIdentifierKey]).typeIdentifier,
                    let mimeType = UTType(typeIdentifier)?.preferredMIMEType {
            return mimeType
        }
        else if self.pathExtension.isEmpty == false,
                let mimeType = UTType(filenameExtension: pathExtension)?.preferredMIMEType {
            return mimeType
        }
        else {
            return "application/octet-stream"
        }
    }
}
