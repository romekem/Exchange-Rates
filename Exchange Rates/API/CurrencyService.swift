//
//  CurrencyService.swift
//  Exchange Rates
//
//  Created by Roman Matusewicz on 25/05/2020.
//  Copyright © 2020 Roman Matusewicz. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct CurrencyService {
    static let shared = CurrencyService()
    
    func fetchCurrenciesRates(fromTable table: String, completion: @escaping([Currency]) -> Void){
        var currenciesRates = [Currency]()
        
        let url = REF_NBP_TABLES + table + REF_FORMAT_JSON
        
        AF.request(url, method: .get).responseJSON { (response) in
            guard let responseData = response.data else {return}
            
            let responseJSON: JSON = JSON(responseData)
            
            let rates = responseJSON[0]["rates"].count-1
            if rates > 0 {
                for i in 0...rates {
                    let name = responseJSON[0]["rates"][i]["currency"].stringValue
                    let code = responseJSON[0]["rates"][i]["code"].stringValue
                    let date = responseJSON[0]["effectiveDate"].stringValue
                    
                    let curAmount: String?
                    if table == "c"{
                        curAmount = responseJSON[0]["rates"][i]["bid"].stringValue
                    } else {
                        curAmount = responseJSON[0]["rates"][i]["mid"].stringValue
                    }
                    guard let amount = curAmount else {return}
                    
                    let cur = Currency(name: name, code: code, amount: amount, date: date, table: table)
                    currenciesRates.append(cur)
                }
                
                completion(currenciesRates)
            }
        }
    }
    
    func fetchCurrencyRates(fromDate startDate: String, tillDate endDate: String, currency: Currency, completion: @escaping([Currency]) -> Void){
        var currencyRates = [Currency]()
        
        let url = REF_NBP_RATES + currency.table + "/" + currency.code + "/" + startDate + "/" + endDate + REF_FORMAT_JSON
         
        AF.request(url, method: .get).responseJSON { (response) in
            
            guard let responseData = response.data else {return}
            
            let responseJSON = JSON(responseData)
            
            let number = responseJSON["rates"].count

            if number > 0 {
                if currency.table == "c"{
                    for i in 0...number-1 {
                        let date = responseJSON["rates"][i]["effectiveDate"].stringValue
                        let amount = responseJSON["rates"][i]["bid"].stringValue
                        
                        let cur = Currency(name: currency.name, code: currency.code, amount: amount, date: date, table: currency.table)
                        currencyRates.append(cur)
                    }
                } else {
                    for i in 0...number-1 {
                        let date = responseJSON["rates"][i]["effectiveDate"].stringValue
                        let amount = responseJSON["rates"][i]["mid"].stringValue
                        
                        let cur = Currency(name: currency.name, code: currency.code, amount: amount, date: date, table: currency.table)
                        currencyRates.append(cur)
                
                    }
                }
                completion(currencyRates)
            }
            
            
            
        }

    }
    
}
