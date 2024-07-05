//
//  File.swift
//
//
//  Created by Eduardo on 05/07/24.
//

import Foundation

public enum BinanceAPI: EndpointProtocol {
    
    case getPrice(symbol: String?)
    
    public var host: String {
        return "api.binance.com"
    }
    
    public var scheme: String {
        return "https"
    }
    
    public var path: String {
        switch self {
            case .getPrice(let symbol):
                if let symbol = symbol {
                    return "/api/v3/ticker/price?symbol=\(symbol)"
                }
                return "/api/v3/ticker/price"
        }
    }
    
    public var method: RequestMethod {
        switch self {
            case .getPrice:
                return .get
        }
    }
    
    public var header: [String: String]? {
        switch self {
            default:
                return nil
        }
    }
    
    public var body: [String: String]? {
        switch self {
            default:
                return nil
        }
    }
    
    public var queryParams: [String: String]? {
        return nil
    }
    
    public var pathParams: [String: String]? {
        return nil
    }
}
