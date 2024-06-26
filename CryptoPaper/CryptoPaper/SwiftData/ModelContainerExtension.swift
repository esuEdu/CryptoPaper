//
//  ModelContainerExtension.swift
//  CryptoPaper
//
//  Created by Eduardo on 26/06/24.
//

import Foundation
import SwiftData

extension ModelContainer {
    
    static let appContainer: ModelContainer = {
        do {
            let container = try ModelContainer(for: Coin.self, User.self, Transactions.self, configurations: ModelConfiguration(isStoredInMemoryOnly: false))
            return container
        } catch {
            fatalError("Failed to create appContainer")
        }
    }()
    
    static let testContainer: ModelContainer = {
        do {
            let container = try ModelContainer(for: Coin.self, User.self, Transactions.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
            return container
        } catch {
            fatalError("Failed to create PreviewContainer")
        }
    }()
}
