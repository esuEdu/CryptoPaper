//
//  File.swift
//  
//
//  Created by Eduardo on 06/07/24.
//

import Foundation
@testable import CryptoPaperNetwork

struct MockEndpoint: EndpointProtocol {
    var host: String = "api.example.com"
    var scheme: String = "https"
    var path: String = "/test"
    var method: RequestMethod = .get
    var header: [String : String]? = nil
    var body: [String : String]? = nil
    var queryParams: [String : String]? = nil
    var pathParams: [String : String]? = nil
}

struct MockResponse: Codable {
    let id: Int
    let message: String
}
