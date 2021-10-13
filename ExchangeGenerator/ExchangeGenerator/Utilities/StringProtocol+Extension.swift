//
//  StringProtocol+Extension.swift
//  ExchangeGenerator
//
//  Created by Tundzhay Dzhansaz on 13.10.2021.
//

import Foundation

//MARK: - Manage first letter of Strings
extension StringProtocol {
  var firstUppercased: String { prefix(1).uppercased() + dropFirst() }
  var firstLowercased: String { prefix(1).lowercased() + dropFirst() }
  var firstCapitalized: String { prefix(1).capitalized + dropFirst() }
}


