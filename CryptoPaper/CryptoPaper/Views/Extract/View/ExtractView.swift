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

    private var extractsTest: [Transactions] = []
//    private var extractsTest: [Transaction] = [Transaction(id: UUID(), date: Date(), coinBought: Coins(name: "BTC", amount: 1), coinSold: Coins(name: "USDT", amount: 61000)), Transaction(id: UUID(), date: Date(), coinBought: Coins(name: "ETH", amount: 345), coinSold: Coins(name: "USDT", amount: 10))]
    private var dataController = DataController()
    
    weak var coordinator: MainCoordinator?
    private var viewModel = ExtractViewModel()
    private var cancellables = Set<AnyCancellable>()
    private let balanceLabel = UILabel()

    private let ExtractViewTableView: UITableView = {
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
        guard let data = dataController.fetchUsers().transactions else { return }
        self.extractsTest = data
        
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        self.title = "Extract"
        
        balanceLabel.translatesAutoresizingMaskIntoConstraints = false
        ExtractViewTableView.translatesAutoresizingMaskIntoConstraints = false
        
        balanceLabel.accessibilityIdentifier = "Balance" // Add this line
        ExtractViewTableView.accessibilityIdentifier = "Extract Table" // Add this line
        
        balanceLabel.textAlignment = .center
        balanceLabel.font = UIFont.boldSystemFont(ofSize: 24)
        
    
        ExtractViewTableView.dataSource = self
        ExtractViewTableView.delegate = self
        
        view.addSubview(balanceLabel)
        view.addSubview(ExtractViewTableView)
        
        NSLayoutConstraint.activate([
            balanceLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            balanceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            balanceLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            ExtractViewTableView.topAnchor.constraint(equalTo: balanceLabel.bottomAnchor, constant: 16),
            ExtractViewTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            ExtractViewTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            ExtractViewTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func bindViewModel() {
        viewModel.model.$totalBalance
            .receive(on: RunLoop.main)
            .sink { [weak self] totalBalance in
                self?.balanceLabel.text = String(format: "$%.2f", totalBalance)
            }
            .store(in: &cancellables)
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
        
        cell.config(/*with: image,*/ tickerLabel: "\(extractsTest[indexPath.row].coinBought.name)", paidValue: extractsTest[indexPath.row].coinSold.amount, quantityPurchased: extractsTest[indexPath.row].coinBought.amount)
        
        return cell
    }
}
