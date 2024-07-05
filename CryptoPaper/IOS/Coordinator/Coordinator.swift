//
//  Coordinator.swift
//  CryptoPaper
//
//  Created by Eduardo on 20/06/24.
//

import Foundation
import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    func start()
}
