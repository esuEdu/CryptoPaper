//
//  ServiceManagerTests.swift
//  CryptoPaperTests
//
//  Created by Gabriel Eduardo on 21/06/24.
//

import XCTest
@testable import CryptoPaper

class ServiceManagerTests: XCTestCase {
    private var manager: ServiceManager!
    
    // Build the objects that we're gonna use
    override func setUpWithError() throws {
        manager = ServiceManager()
    }
    
    // Destroy the objects that we're not gonna use anymore
    override func tearDownWithError() throws {
        manager = nil
    }
}
