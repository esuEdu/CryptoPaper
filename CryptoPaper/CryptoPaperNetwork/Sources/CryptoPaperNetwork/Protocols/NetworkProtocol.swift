//
//  NetworkProtocol.swift
//
//
//  Created by Eduardo on 05/07/24.
//

import Foundation
import Combine

@available(iOS 13.0, *)
internal protocol NetworkProtocol {
    func sendRequest<T: Codable>(endpoint: EndpointProtocol) async throws -> T?
    func sendRequest<T: Codable>(endpoint: EndpointProtocol, type: T.Type) -> AnyPublisher<T, NetworkError>
}

@available(iOS 13.0, *)
extension NetworkProtocol {
    func createRequest(endpoint: EndpointProtocol) -> URLRequest? {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host
        urlComponents.path = urlComponents.path
        
        // Adding query parameters if present
        if let queryParams = endpoint.queryParams {
            urlComponents.queryItems = queryParams.map { URLQueryItem(name: $0.key, value: $0.value) }
        }
        
        guard let url = urlComponents.url else {
            return nil
        }
        
        let encoder = JSONEncoder()
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.header
        
        //set the request body
        if let body = endpoint.body {
            request.httpBody = try? encoder.encode(body)
        }
        
        return request
    }
}
