// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation
import Combine

@available(iOS 13.0, *)
public class NetworkManager: NetworkProtocol {
    
    public init() {}
    
    public func sendRequest<T: Codable>(endpoint: EndpointProtocol) async throws -> T? {
        guard let request = createRequest(endpoint: endpoint) else {
            throw NetworkError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.requestFailed
        }
        
        switch httpResponse.statusCode {
        case 200...299:
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        case 401:
            throw NetworkError.unauthorized
        case 400...499:
            throw NetworkError.requestFailed
        case 500...599:
            throw NetworkError.serverError(message: "Server returned status code \(httpResponse.statusCode)")
        default:
            throw NetworkError.unknown
        }
    }
    
    public func sendRequest<T: Codable>(endpoint: EndpointProtocol, type: T.Type) -> AnyPublisher<T, NetworkError> {
        guard let request = createRequest(endpoint: endpoint) else {
            return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response -> T in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw NetworkError.requestFailed
                }
                
                switch httpResponse.statusCode {
                case 200...299:
                    let decoder = JSONDecoder()
                    return try decoder.decode(T.self, from: data)
                case 401:
                    throw NetworkError.unauthorized
                case 400...499:
                    throw NetworkError.requestFailed
                case 500...599:
                    throw NetworkError.serverError(message: "Server returned status code \(httpResponse.statusCode)")
                default:
                    throw NetworkError.unknown
                }
            }
            .mapError { error in
                if let networkError = error as? NetworkError {
                    return networkError
                } else {
                    return NetworkError.unknown
                }
            }
            .eraseToAnyPublisher()
    }
}

