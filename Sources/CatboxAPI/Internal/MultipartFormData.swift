//
//  MultipartFormData.swift
//
//
//  Created by Dana Buehre on 9/19/24.
//

import Foundation

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

public struct MultipartFormData {
    private let boundary: String = UUID().uuidString
    private var httpBody = NSMutableData()
    let url: URL
    
    public init(url: URL) {
        self.url = url
    }
    
    public init(url: URL, fieldName name: String, fileName: String, data: Data, mimeType: String) {
        self.url = url
        self.addDataField(named: name, fileName: fileName, data: data, mimeType: mimeType)
    }
    
    public mutating func addTextField(named name: String, value: String) {
        httpBody.append(textFormField(named: name, value: value))
    }
    
    private mutating func textFormField(named name: String, value: String) -> String {
        var fieldString = "--\(boundary)\r\n"
        fieldString += "Content-Disposition: form-data; name=\"\(name)\"\r\n"
        fieldString += "Content-Type: text/plain; charset=ISO-8859-1\r\n"
        fieldString += "Content-Transfer-Encoding: 8bit\r\n"
        fieldString += "\r\n"
        fieldString += "\(value)\r\n"
        
        return fieldString
    }
    
    public mutating func addDataField(named name: String, fileName: String, data: Data, mimeType: String) {
        httpBody.append(dataFormField(named: name, fileName: fileName, data: data, mimeType: mimeType))
    }
    
    private mutating func dataFormField(named name: String,
                                        fileName: String,
                                        data: Data,
                                        mimeType: String) -> Data {
        let fieldData = NSMutableData()
        
        fieldData.append("--\(boundary)\r\n")
        fieldData.append("Content-Disposition: form-data; name=\"\(name)\"; filename=\"\(fileName)\"\r\n")
        fieldData.append("Content-Type: \(mimeType)\r\n")
        fieldData.append("\r\n")
        fieldData.append(data)
        fieldData.append("\r\n")
        
        return fieldData as Data
    }
    
    public var urlRequest: URLRequest {
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        httpBody.append("--\(boundary)--")
        request.httpBody = httpBody as Data
        
        return request
    }
}

private extension NSMutableData {
    func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            self.append(data)
        }
    }
}
