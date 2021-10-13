//
//  HistoricalCurrency.swift
//  ExchangeGenerator
//
//  Created by Tundzhay Dzhansaz on 13.10.2021.
//


import Foundation
import UIKit


//MARK: - Custom data model for cryptocurrencies [name, rate]
class Historical: NSObject {
  var base: String = ""
  var rates = Double()

    
    init(base: String, rates: Double){
        self.base = base
        self.rates = rates
    }
    
}

