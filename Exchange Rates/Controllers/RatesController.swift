//
//  RatesController.swift
//  exchange rates
//
//  Created by Roman Matusewicz on 25/05/2020.
//  Copyright © 2020 Roman Matusewicz. All rights reserved.
//

import UIKit

private let reuseIdentifier = "RatesCell"

class RatesController: UITableViewController {
    // MARK: - Properties
    
    private var tableType: String? {
        didSet{
            fetchCurrenciesRates()
        }
    }
    
    private var currenciesRates = [Currency]() {
        didSet{
            tableView.reloadData()
        }
    }
    
    private var headerView = RatesHeader()
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        configureNavigationBar()
        fetchCurrenciesRates()
        
    }
    // MARK: - API
    
    func fetchCurrenciesRates(){
        self.tableView.refreshControl?.beginRefreshing()
        CurrencyService.shared.fetchCurrenciesRates(fromTable: tableType ?? "a") { (currencies) in
            self.currenciesRates = currencies
            self.tableView.refreshControl?.endRefreshing()
        }
    }
    // MARK: - Selectors
    
    @objc func handleRefresh(){
        fetchCurrenciesRates()
    }

    // MARK: - Helpers
    
    func configureUI(){
        view.backgroundColor = .white
        
        tableView.tableHeaderView = headerView
        headerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 60)
        
        tableView.register(RatesCell.self, forCellReuseIdentifier: reuseIdentifier)
        
        headerView.delegate = self
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    func configureNavigationBar(){
        navigationController?.navigationBar.barTintColor = .nbpGreen
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.isHidden = false
            
        navigationItem.title = "Exchange Rates"
    }
}

extension RatesController {
    // MARK: - UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! RatesCell
        cell.currency = self.currenciesRates[indexPath.row]
    
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currenciesRates.count
    }
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = CurrencyDetailController(currency:  self.currenciesRates[indexPath.row])
        navigationController?.pushViewController(controller, animated: true)
    }

}

    // MARK: - RatesHeaderDelegate

extension RatesController: RatesHeaderDelegate {
    func handleTableType(table type: String) {
        self.tableType = type.lowercased()
    }
}
