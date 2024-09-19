//
//  CatboxAPIError.swift
//
//
//  Created by Dana Buehre on 9/19/24.
//

import Foundation

public enum CatboxAPIError: LocalizedError {
    case emptyResponseError
    case decodingError
    case invalidResponse(String)
    case localUrlNotSupported(String)
    case remoteUrlNotSupported(String)
    
    public var errorDescription: String? {
        switch self {
        case .emptyResponseError:
            return "the request returned an empty response"
        case .decodingError:
            return "the request returned a response that could not be read"
        case .invalidResponse(let response):
            return "the request returned a response in an invalid format: \(response)"
        case .localUrlNotSupported(let url):
            return "unexpectedly found a local file url while processing the request, local files are not supported for this request type: \(url)"
        case .remoteUrlNotSupported(let url):
            return "unexpectedly found a remote file url while processing the request, remote files are not supported for this request type: \(url)"
        }
    }
}
