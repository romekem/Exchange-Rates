//
//  RatesHeader.swift
//  Exchange Rates
//
//  Created by Roman Matusewicz on 28/05/2020.
//  Copyright © 2020 Roman Matusewicz. All rights reserved.
//

import UIKit

protocol RatesHeaderDelegate: class {
    func handleTableType(table type: String)
}

class RatesHeader: UIView {
    // MARK: - Properties
    
    weak var delegate: RatesHeaderDelegate?
    
    private let tableLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "Tabela:"
        return label
    }()
    
    private let tablePickerView = UIPickerView()
    
    private let tables = ["A", "B", "C"]

    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        backgroundColor = .white
        
        tablePickerView.delegate = self
        tablePickerView.dataSource = self
        
        addSubview(tableLabel)
        tableLabel.centerY(inView: self, leftAnchor: leftAnchor, paddingLeft: 16)
        
        addSubview(tablePickerView)
        tablePickerView.center(inView: self)
        tablePickerView.setDimensions(width: 80, height: 50)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
    // MARK: - UIPickerViewDelegate
extension RatesHeader: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return tables[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 40.0
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 30.0
    }
    
}

    // MARK: - UIPickerViewDataSource

extension RatesHeader: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return tables.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        delegate?.handleTableType(table: tables[row])
    }
}
