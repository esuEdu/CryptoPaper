//
//  File.swift
//  
//
//  Created by Eduardo on 06/07/24.
//

import Foundation
import Combine

@available(iOS 13.0.0, *)
public protocol URLSessionProtocol {
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol {}
