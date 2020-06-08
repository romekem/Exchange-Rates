//
//  RatesCell.swift
//  Exchange Rates
//
//  Created by Roman Matusewicz on 25/05/2020.
//  Copyright © 2020 Roman Matusewicz. All rights reserved.
//

import UIKit

class RatesCell:UITableViewCell {
    
    // MARK: - Properties
    
    var currency: Currency? {
        didSet{
            configure()
        }
    }
    
    private let currencyCodeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private let currencyNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    private let amountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
           
        backgroundColor = .white

        addSubview(currencyCodeLabel)
        currencyCodeLabel.anchor(top: topAnchor, left: leftAnchor, paddingTop: 6, paddingLeft: 8)
        
        addSubview(currencyNameLabel)
        currencyNameLabel.anchor(top: currencyCodeLabel.bottomAnchor, left: leftAnchor, paddingTop: 4, paddingLeft: 8)
        
        addSubview(amountLabel)
        amountLabel.anchor(top: topAnchor, right: rightAnchor, paddingTop: 6, paddingRight: 4)
        
        addSubview(dateLabel)
        dateLabel.anchor(top: amountLabel.bottomAnchor, right: rightAnchor, paddingTop: 4, paddingRight: 4)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    func configure(){
        
        currencyNameLabel.text = currency?.name
        currencyCodeLabel.text = currency?.code
        dateLabel.text = currency?.date
        if let amount = currency?.amount{
            amountLabel.text = "\(amount) PLN"
        }
    }
}
