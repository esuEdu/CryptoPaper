//
//  DataController.swift
//  CryptoPaper
//
//  Created by Samu Lima on 25/06/24.
//

import Foundation
import SwiftData

class DataController {
    static let shared = DataController()
    let container: ModelContainer

    private init() {
        do {
            container = try ModelContainer(for: Coins.self, User.self, Transactions.self)
        } catch {
            fatalError("Failed to initialize the model container: \(error)")
        }
    }
    
}
