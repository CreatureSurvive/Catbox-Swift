//
//  CatboxClient.swift
//
//
//  Created by Dana Buehre on 9/19/24.
//

import Foundation

public struct CatboxClient {
    public static let sharedClient = CatboxClient()
    
    private init() {}
    
    static let dispatchQueue: DispatchQueue = {
        return DispatchQueue.init(label: "catbox.client", qos: .userInitiated, attributes: .concurrent, autoreleaseFrequency: .workItem, target: nil)
    }()
    
    static let operationQueue: OperationQueue = {
        let queue = OperationQueue.init()
        queue.name = "catbox.client"
        queue.maxConcurrentOperationCount = 10
        queue.qualityOfService = .default
        queue.underlyingQueue = dispatchQueue
        return queue
    }()
    
    static let session: URLSession = {
        let configuration = URLSessionConfiguration.ephemeral
        return URLSession(configuration: configuration, delegate: nil, delegateQueue: operationQueue)
    }()
    
    static let catboxApiEndpoint: URL = URL(string: "https://catbox.moe/user/api.php")!
    
    private func handleRequest(_ request: URLRequest) async throws -> String {
        do {
            let (data, response) = try await Self.session.data(for: request)
            
            if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                print("status (\(statusCode)): \(HTTPURLResponse.localizedString(forStatusCode: statusCode))")
            }
            
            guard data.isEmpty == false else {
                throw CatboxAPIError.emptyResponseError
            }
            
            guard let string = String(data: data, encoding: .utf8) else {
                throw CatboxAPIError.decodingError
            }
            
            return string
            
        } catch {
            print(error.localizedDescription)
            throw error
        }
    }
    
    private func handleRequest(_ request: URLRequest) async throws -> URL {
        do {
            let string: String = try await handleRequest(request)
            
            guard let url = URL(string: string) else {
                throw CatboxAPIError.invalidResponse(string)
            }
            return url
            
        } catch {
            print(error.localizedDescription)
            throw error
        }
    }
}

// MARK: - Client File Upload
public extension CatboxClient {
    
    func request(_ request: CatboxFileUploadRequest) async throws -> URL {
        
        var form = MultipartFormData(url: Self.catboxApiEndpoint)
        form.addTextField(named: "reqtype", value: request.requestType)
        form.addTextField(named: "userhash", value: request.userhash ?? "")
        form.addDataField(named: "fileToUpload", fileName: request.fileName, data: request.data, mimeType: request.mimeType)
        
        return try await handleRequest(form.urlRequest)
    }
}

// MARK: - Client remote URL Upload
public extension CatboxClient {
    
    func request(_ request: CatboxURLUploadRequest) async throws -> URL {
        
        guard !request.url.isFileURL else {
            throw CatboxAPIError.localUrlNotSupported(request.url.absoluteString)
        }
        
        var form = MultipartFormData(url: Self.catboxApiEndpoint)
        form.addTextField(named: "reqtype", value: request.requestType)
        form.addTextField(named: "userhash", value: request.userhash ?? "")
        form.addTextField(named: "url", value: request.url.absoluteString)
        
        return try await handleRequest(form.urlRequest)
    }
}

// MARK: - Client local file URL Upload
public extension CatboxClient {
    
    func request(_ request: CatboxLocalURLUploadRequest) async throws -> URL {
        
        guard request.url.isFileURL else {
            throw CatboxAPIError.remoteUrlNotSupported(request.url.absoluteString)
        }
        
        let data = try Data(contentsOf: request.url)
        var form = MultipartFormData(url: Self.catboxApiEndpoint)
        form.addTextField(named: "reqtype", value: request.requestType)
        form.addTextField(named: "userhash", value: request.userhash ?? "")
        form.addDataField(named: "fileToUpload", fileName: request.url.lastPathComponent, data: data, mimeType: request.url.mimeType())
        
        return try await handleRequest(form.urlRequest)
    }
}

// MARK: - Client Files Upload
public extension CatboxClient {
    
    func request(_ request: CatboxFilesUploadRequest) async throws -> [URL] {
        var urls = [URL]()
        
        for file in request.files {
            if file.isFileURL {
                let form = CatboxLocalURLUploadRequest(
                    userhash: request.userhash,
                    url: file
                )
                let url = try await self.request(form)
                urls.append(url)
            } else {
                let form = CatboxURLUploadRequest(
                    userhash: request.userhash,
                    url: file)
                let url = try await self.request(form)
                urls.append(url)
            }
        }
        
        return urls
    }
}


// MARK: - Client Delete Files
public extension CatboxClient {
    
    func request(_ request: CatboxDeleteFilesRequest) async throws -> String {
        
        var form = MultipartFormData(url: Self.catboxApiEndpoint)
        form.addTextField(named: "reqtype", value: request.requestType)
        form.addTextField(named: "userhash", value: request.userhash)
        form.addTextField(named: "files", value: request.files.joined(separator: " "))
        
        return try await handleRequest(form.urlRequest)
    }
}
