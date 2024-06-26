//
//  Extractview.swift
//  CryptoPaper
//
//  Created by Jairo Júnior on 25/06/24.
//

import UIKit
import Combine

struct Transaction{
    var id: UUID
    var date: Date
    var coinBought: Coins
    var coinSold: Coins
}
struct Coins{
    var name: String
    var amount: Double
}

class ExtractView: UIViewController {
    private var extractsTest: [Transaction] = [Transaction(id: UUID(), date: Date(), coinBought: Coins(name: "BTC", amount: 3426), coinSold: Coins(name: "ETH", amount: 5)), Transaction(id: UUID(), date: Date(), coinBought: Coins(name: "ETH", amount: 345), coinSold: Coins(name: "BTC", amount: 435))]
    
    weak var coordinator: MainCoordinator?
    private var viewModel = ExtractViewModel()
    private var cancellables = Set<AnyCancellable>()
    private let balanceLabel = UILabel()

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.allowsSelection = false
        tableView.register(CustomCell.self, forCellReuseIdentifier: CustomCell.identifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        bindViewModel()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        self.title = "Extract"
        
        balanceLabel.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        balanceLabel.accessibilityIdentifier = "Balance" // Add this line
        tableView.accessibilityIdentifier = "Extract Table" // Add this line
        
        balanceLabel.textAlignment = .center
        balanceLabel.font = UIFont.boldSystemFont(ofSize: 24)
        
    
        tableView.dataSource = self
        tableView.delegate = self
        
        view.addSubview(balanceLabel)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            balanceLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            balanceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            balanceLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            tableView.topAnchor.constraint(equalTo: balanceLabel.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func bindViewModel() {
        viewModel.model.$totalBalance
            .receive(on: RunLoop.main)
            .sink { [weak self] totalBalance in
                self?.balanceLabel.text = String(format: "$%.2f", totalBalance)
            }
            .store(in: &cancellables)
        
//        viewModel.$coins
//            .receive(on: RunLoop.main)
//            .sink { [weak self] _ in
//                self?.tableView.reloadData()
//            }
//            .store(in: &cancellables)
    }
}


extension ExtractView: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.extractsTest.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.identifier, for: indexPath) as? CustomCell else{
            fatalError("The tableView could not dequeue a CustomCell in ExtractView")
        }
        
        let image = UIImage(systemName: "bitcoinsign.circle")!

        cell.config(with: image, tickerLabel: "\(extractsTest[indexPath.row].coinBought.name)", paidValue: extractsTest[indexPath.row].coinSold.amount, quantityPurchased: extractsTest[indexPath.row].coinBought.amount)
        
        return cell
    }
}
