//
//  File.swift
//
//
//  Created by Eduardo on 05/07/24.
//

import Foundation

public enum BinanceAPI: EndpointProtocol {
    
    case getPrice(symbol: String?)
    
    var host: String {
        return "api.binance.com"
    }
    
    var scheme: String {
        return "https"
    }
    
    var path: String {
        switch self {
            case .getPrice(let symbol):
                if let symbol = symbol {
                    return "/api/v3/ticker/price?symbol=\(symbol)"
                }
                return "/api/v3/ticker/price"
        }
    }
    
    var method: RequestMethod {
        switch self {
            case .getPrice:
                return .get
        }
    }
    
    var header: [String: String]? {
        switch self {
            default:
                return nil
        }
    }
    
    var body: [String: String]? {
        switch self {
            default:
                return nil
        }
    }
    
    var queryParams: [String: String]? {
        return nil
    }
    
    var pathParams: [String: String]? {
        return nil
    }
}
