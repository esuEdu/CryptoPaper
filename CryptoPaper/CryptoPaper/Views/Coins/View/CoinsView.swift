//
//  CoinsView.swift
//  CryptoPaper
//
//  Created by Eduardo on 20/06/24.
//
import UIKit
import Combine

class CoinsListView: UIViewController {
    
    weak var coordinator: MainCoordinator?
    
    private var viewModel = CoinsViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    private let tableView = UITableView()
    private let balanceLabel = UILabel()
    private let extractButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        bindViewModel()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        self.title = "Coins"
        
        balanceLabel.translatesAutoresizingMaskIntoConstraints = false
        balanceLabel.textAlignment = .center
        balanceLabel.font = UIFont.boldSystemFont(ofSize: 24)
        balanceLabel.accessibilityIdentifier = "Balance"
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CoinCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.accessibilityIdentifier = "Coin Table"
        
        extractButton.translatesAutoresizingMaskIntoConstraints = false
        extractButton.setTitle("Extract", for: .normal)
        extractButton.addTarget(self, action: #selector(extractButtonTapped), for: .touchUpInside)
        
        view.addSubview(balanceLabel)
        view.addSubview(tableView)
        view.addSubview(extractButton)
        
        NSLayoutConstraint.activate([
            balanceLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            balanceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            balanceLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 16),
            
            extractButton.topAnchor.constraint(equalTo: balanceLabel.bottomAnchor, constant: 16),
            extractButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            extractButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 16),
            
            tableView.topAnchor.constraint(equalTo: extractButton.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func bindViewModel() {
        viewModel.$totalBalance
            .receive(on: RunLoop.main)
            .sink { [weak self] totalBalance in
                self?.balanceLabel.text = String(format: "Balance: $%.2f", totalBalance)
            }
            .store(in: &cancellables)
        
        viewModel.$coins
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)
    }
    
    @objc private func extractButtonTapped() {
        self.coordinator?.goToExtractView()
    }
}

extension CoinsListView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.coins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CoinCell", for: indexPath)
        let coin = viewModel.coins[indexPath.row]
        cell.textLabel?.text = "\(coin.symbol): $\(coin.price)"
        return cell
    }
}

extension CoinsListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let coin = viewModel.coins[indexPath.row]
        coordinator?.goToCoinView(coin: Coin(name: coin.symbol, amount: Double(coin.price) ?? 0))
    }
}
