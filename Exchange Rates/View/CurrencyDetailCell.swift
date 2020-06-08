//
//  CurrencyDetailCell.swift
//  Exchange Rates
//
//  Created by Roman Matusewicz on 03/06/2020.
//  Copyright © 2020 Roman Matusewicz. All rights reserved.
//

import UIKit

class CurrencyDetailCell: UITableViewCell {
    // MARK: - Properties
    
    var currency: Currency? {
        didSet{
            configure()
        }
    }

    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "20-05-2020"
        return label
    }()
      
    private let amountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "3.50 PLN"
        return label
    }()
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
           
        backgroundColor = .white
        
        addSubview(dateLabel)
        dateLabel.anchor(left: leftAnchor, paddingLeft: 20)
        dateLabel.centerY(inView: self)
        
        addSubview(amountLabel)
        amountLabel.anchor(right: rightAnchor, paddingRight: 22)
        amountLabel.centerY(inView: self)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Helpers
    
    func configure(){
        dateLabel.text = currency?.date
        if let amount = currency?.amount{
            amountLabel.text = "\(amount) PLN"
        }
           
    }
    
}
