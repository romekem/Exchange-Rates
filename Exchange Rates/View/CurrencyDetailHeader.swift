//
//  currencyDetailHeader.swift
//  Exchange Rates
//
//  Created by Roman Matusewicz on 03/06/2020.
//  Copyright © 2020 Roman Matusewicz. All rights reserved.
//

import UIKit

protocol CurrencyDetailHeaderDelegate: class {
    func handleDownloadRates()
    func handleStarDate(startDate: String)
    func handleEndDate(endDate: String)
}

class CurrencyDetailHeader: UIView {
    // MARK: - Properties
    
    weak var delegate: CurrencyDetailHeaderDelegate?
    
    private var currencyName: String
    
    private let datePicker = UIDatePicker()
    
    lazy var startDateTextField: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .none
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.textAlignment = .left
        tf.placeholder = "Data początkowa"
        tf.setDimensions(width: 116, height: 30)
        tf.backgroundColor = .white
        return tf
    }()

    private var endDateTextField: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .none
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.textAlignment = .left
        tf.placeholder = "Data końcowa"
//        tf.setDimensions(width: 110, height: 30)
        tf.backgroundColor = .white
        return tf
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    lazy var downloadButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Pobierz", for: .normal)
        btn.layer.borderColor = UIColor.nbpGreen.cgColor
        btn.layer.borderWidth = 1.25
        btn.setTitleColor(.nbpGreen, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.addTarget(self, action: #selector(handleDownloadRates), for: .touchUpInside)
        return btn
    }()
    
    // MARK: - Lifecycle
        
    init(currencyName: String) {
        self.currencyName = currencyName
        super.init(frame: .zero)
            
        backgroundColor = .white
        
        startDateTextField.delegate = self
        endDateTextField.delegate = self
        
        addSubview(nameLabel)
        nameLabel.text = currencyName
        nameLabel.centerX(inView: self)
        nameLabel.anchor(top: topAnchor, paddingTop: 8)
        
        addSubview(downloadButton)
        downloadButton.anchor(top: nameLabel.bottomAnchor, right: rightAnchor, paddingTop: 20, paddingRight: 20, width: 80, height: 30)
        downloadButton.layer.cornerRadius = 30 / 2
                
        addSubview(startDateTextField)
        startDateTextField.anchor(top: nameLabel.bottomAnchor, left: leftAnchor, paddingTop: 20, paddingLeft: 20)
        
        addSubview(endDateTextField)
        endDateTextField.anchor(top: nameLabel.bottomAnchor, left: startDateTextField.rightAnchor, right: downloadButton.leftAnchor, paddingTop: 20, paddingLeft: 20, paddingRight: 10, height: 30)
        
        createDatePicker()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    // MARK: - Selectors
    
    @objc func handleDate(){
        let formatter = formatterSettings()
        if startDateTextField.isFirstResponder {
            let startDate = formatter.string(from: datePicker.date)
            startDateTextField.text = startDate
            
            delegate?.handleStarDate(startDate: startDate)
            
        } else if endDateTextField.isFirstResponder {
            let endDate = formatter.string(from: datePicker.date)
            endDateTextField.text = endDate
            
            delegate?.handleEndDate(endDate: endDate)
        }
    }
    
    @objc func handleEndEditing(){
        endEditing(true)
    }
    
    @objc func handleDownloadRates(){
        delegate?.handleDownloadRates()
        endEditing(true)
    }
    // MARK: - Helpers
    
    func createDatePicker(){
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(handleEndEditing))
        toolbar.setItems([doneButton], animated: true)
        
        startDateTextField.inputAccessoryView = toolbar
        endDateTextField.inputAccessoryView = toolbar
        
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(handleDate), for: UIControl.Event.valueChanged)
        
        startDateTextField.inputView = datePicker
        endDateTextField.inputView = datePicker
        
        datePicker.maximumDate = Date()
    }
    
    func formatterSettings()-> DateFormatter {
        let formatter = DateFormatter()
        formatter.timeStyle = DateFormatter.Style.none
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }
}
    // MARK: - UITextFieldDelegate

extension CurrencyDetailHeader: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 10
        let currentString: NSString = textField.text! as NSString
        let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
}
