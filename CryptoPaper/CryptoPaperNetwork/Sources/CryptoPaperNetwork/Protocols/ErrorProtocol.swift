//
//  File.swift
//
//
//  Created by Eduardo on 05/07/24.
//

import Foundation

// Define a protocol for errors
public protocol ErrorProtocol: LocalizedError {
    var title: String? { get }
    var code: Int { get }
}

public enum NetworkError: ErrorProtocol {
    case invalidURL
    case requestFailed
    case decodingError
    case serverError(message: String)
    case unauthorized
    case unknown
    
    public var title: String? {
        switch self {
            case .invalidURL:
                return "Invalid URL"
            case .requestFailed:
                return "Request Failed"
            case .decodingError:
                return "Decoding Error"
            case .serverError:
                return "Server Error"
            case .unauthorized:
                return "Unauthorized"
            case .unknown:
                return "Unknown Error"
        }
    }
    
    public var code: Int {
        switch self {
            case .invalidURL:
                return 1001
            case .requestFailed:
                return 1002
            case .decodingError:
                return 1003
            case .serverError:
                return 1004
            case .unauthorized:
                return 1005
            case .unknown:
                return 1000
        }
    }
    
    public var errorDescription: String? {
        switch self {
            case .invalidURL:
                return "The URL provided was invalid."
            case .requestFailed:
                return "The request failed due to an unknown error."
            case .decodingError:
                return "There was an error decoding the response."
            case .serverError(let message):
                return "Server error: \(message)"
            case .unauthorized:
                return "You are not authorized to perform this action."
            case .unknown:
                return "An unknown error occurred."
        }
    }
}
