//
//  CoinsView.swift
//  CryptoPaper
//
//  Created by Eduardo on 20/06/24.

import UIKit
import Combine
import UIKit
import Combine

class CoinsListView: UIViewController {
    
    weak var coordinator: MainCoordinator?
    
    private var viewModel = CoinsViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    private let tableView = UITableView()
    private let balanceLabel = UILabel()
    private let searchBar = UISearchBar()
    private let refreshControl = UIRefreshControl()
    
    private let extractButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(" Extract ", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        return button
    }()
    
    private let headerView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        bindViewModel()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        self.title = "Coins"
        
        setupHeaderView()
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.delegate = self
        searchBar.placeholder = "Search by ticket"
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(CoinTableViewCell.self, forCellReuseIdentifier: "CoinCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.accessibilityIdentifier = "Coin Table"
        
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        tableView.refreshControl = refreshControl
        
        view.addSubview(headerView)
        view.addSubview(searchBar)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 80),
            
            searchBar.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupHeaderView() {
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.backgroundColor = .white
        
        balanceLabel.translatesAutoresizingMaskIntoConstraints = false
        balanceLabel.textAlignment = .left
        balanceLabel.font = UIFont.boldSystemFont(ofSize: 24)
        balanceLabel.accessibilityIdentifier = "Balance"
        
        extractButton.addTarget(self, action: #selector(extractButtonTapped), for: .touchUpInside)
        
        headerView.addSubview(balanceLabel)
        headerView.addSubview(extractButton)
        
        NSLayoutConstraint.activate([
            balanceLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            balanceLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            
            extractButton.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            extractButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16)
        ])
    }
    
    @objc private func extractButtonTapped() {
        self.coordinator?.goToExtractView(balance: self.viewModel.totalBalance)
    }
    
    @objc private func refreshData() {
        viewModel.fetchCoins()
    }

    private func bindViewModel() {
        viewModel.$totalBalance
            .receive(on: RunLoop.main)
            .sink { [weak self] totalBalance in
                self?.balanceLabel.text = String(format: "$%.2f", totalBalance)
            }
            .store(in: &cancellables)
        
        viewModel.$coins
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
                self?.refreshControl.endRefreshing()
            }
            .store(in: &cancellables)
        
        viewModel.$filteredCoins
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)
    }
}

extension CoinsListView: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filterCoins(with: searchText)
    }
}

extension CoinsListView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filteredCoins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CoinCell", for: indexPath) as! CoinTableViewCell
        let coin = viewModel.filteredCoins[indexPath.row]
        cell.configure(with: coin)
        return cell
    }
}

extension CoinsListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let coin = viewModel.filteredCoins[indexPath.row]
        coordinator?.goToCoinView(coin: Coin(name: coin.symbol, amount: Double(coin.price) ?? 0))
    }
}
