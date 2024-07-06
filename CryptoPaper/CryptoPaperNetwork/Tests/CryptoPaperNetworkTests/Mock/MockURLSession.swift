//
//  File.swift
//  
//
//  Created by Eduardo on 06/07/24.
//

import Foundation
import Combine
@testable import CryptoPaperNetwork

class MockURLSession: URLSessionProtocol {
    var nextData: Data?
    var nextResponse: URLResponse?
    var nextError: Error?
    
    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        if let error = nextError {
            throw error
        }
        return (nextData ?? Data(), nextResponse ?? URLResponse())
    }
    
    func dataTaskPublisher(for request: URLRequest) -> AnyPublisher<(Data, URLResponse), URLError> {
        if let error = nextError as? URLError {
            return Fail(error: error).eraseToAnyPublisher()
        }
        let data = nextData ?? Data()
        let response = nextResponse ?? URLResponse()
        return Just((data, response))
            .setFailureType(to: URLError.self)
            .eraseToAnyPublisher()
    }
}
