//
//  Currency.swift
//  Exchange Rates
//
//  Created by Roman Matusewicz on 26/05/2020.
//  Copyright © 2020 Roman Matusewicz. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Currency {
     var name: String
     var code: String
     var amount: String
     var date: String
    var table: String
    
    init(name: String, code: String, amount: String, date: String, table: String){
        self.name = name
        self.code = code
        self.amount = amount
        self.date = date
        self.table = table
    }
}
