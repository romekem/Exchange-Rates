//
//  CurrencyDetailController.swift
//  exchange rates
//
//  Created by Roman Matusewicz on 25/05/2020.
//  Copyright © 2020 Roman Matusewicz. All rights reserved.
//

import UIKit

private let reuseIdentifier = "CurrencyDetailCell"

class CurrencyDetailController: UITableViewController {
    // MARK: - Properties
    private var currency: Currency
    
    private lazy var headerView = CurrencyDetailHeader(currencyName: currency.name)
    
    private var startDate: String?
    private var endDate: String?
    
    private var currencyRates = [Currency]() {
        didSet{
            tableView.reloadData()
        }
    }
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        configureLeftBarItem()
    }
    
    init(currency: Currency){
        self.currency = currency
        super.init(style: .grouped)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - API
    
    func fetchCurrencyRates(){
        guard let startDate = self.startDate else {return}
        guard let endDate = self.endDate else {return}
        
        let formatter = formatterSettings()
        
        let startDateFromString = formatter.date(from: startDate)
        let endDateFromString = formatter.date(from: endDate)
        
        let result = Calendar.current.dateComponents([.day], from: startDateFromString!, to: endDateFromString!)
        
        guard let comparasionResult = result.day else {return}
        
        if startDateFromString! < endDateFromString! {
            if comparasionResult <= 93 {
                self.tableView.refreshControl?.beginRefreshing()
                CurrencyService.shared.fetchCurrencyRates(fromDate: startDate, tillDate: endDate, currency: currency) { (currencyRates) in
                    self.currencyRates = currencyRates
                    self.tableView.refreshControl?.endRefreshing()
                }
            } else {
                showAlert(message: "Zapytanie przekracza więcej niż 93 dni.")
            }
        } else {
            showAlert(message: "Popraw daty.")
        }
        
        
    }
    // MARK: - Selectors
    
    @objc func handleRefresh(){
        fetchCurrencyRates()
    }
    
    @objc func handleDismiss(){
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Helpers
    
    func configureUI(){
        view.backgroundColor = .white
        
        tableView.tableHeaderView = headerView
        headerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 120)
        
         headerView.delegate = self
        
        tableView.register(CurrencyDetailCell.self, forCellReuseIdentifier: reuseIdentifier)
        
        navigationItem.title = currency.code
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        tableView.refreshControl = refreshControl

    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Błąd", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func configureLeftBarItem(){
        let image = UIImage(named: "baseline_arrow_back_white_24dp")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(handleDismiss))
       
    }
    
    func formatterSettings()-> DateFormatter {
        let formatter = DateFormatter()
        formatter.timeStyle = DateFormatter.Style.none
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }

}

extension CurrencyDetailController {
    // MARK: - UITableViewDataSource

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! CurrencyDetailCell
        cell.currency = self.currencyRates[indexPath.row]
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencyRates.count
    }
}

    // MARK: - CurrencyDetailHeaderDelegate

extension CurrencyDetailController: CurrencyDetailHeaderDelegate{
    func handleStarDate(startDate: String) {
        self.startDate = startDate
    }
    
    func handleEndDate(endDate: String) {
        self.endDate = endDate
    }
    
    func handleDownloadRates() {
        fetchCurrencyRates()
    }
    
}
