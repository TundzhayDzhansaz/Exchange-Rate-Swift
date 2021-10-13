//
//  UIView+Extensions.swift
//  ExchangeGenerator
//
//  Created by Tundzhay Dzhansaz on 13.10.2021.
//

import Foundation
import UIKit

extension UIView {
  
  //MARK:- Helpers funtion to set up views position in ViewController
  
  func anchors(topAnchor: NSLayoutYAxisAnchor?, paddingTop: CGFloat, leftAnchor: NSLayoutXAxisAnchor?, paddingLeft: CGFloat, rightAnchor: NSLayoutXAxisAnchor?, paddingRight: CGFloat, bottomAnchor: NSLayoutYAxisAnchor?, paddingBottom: CGFloat, centerXAnchor: NSLayoutXAxisAnchor?, paddingXAnchor: CGFloat, centerYAnchor: NSLayoutYAxisAnchor?, paddingYAnchor: CGFloat){
    if let topAnchor = topAnchor {
      self.topAnchor.constraint(equalTo: topAnchor, constant: paddingTop).isActive = true
    }
    
    if let leftAnchor = leftAnchor {
      self.leftAnchor.constraint(equalTo: leftAnchor, constant: paddingLeft).isActive = true
    }
    
    if let rightAnchor = rightAnchor {
      self.rightAnchor.constraint(equalTo: rightAnchor, constant: paddingRight).isActive = true
    }
    
    if let bottomAnchor = bottomAnchor {
      self.bottomAnchor.constraint(equalTo: bottomAnchor, constant: paddingBottom).isActive = true
    }
    
    if let centerXAnchor = centerXAnchor {
      self.centerXAnchor.constraint(equalTo: centerXAnchor, constant: paddingXAnchor).isActive = true
    }
    
    if let centerYAnchor = centerYAnchor {
      self.centerYAnchor.constraint(equalTo: centerYAnchor, constant: paddingYAnchor).isActive = true
      
    }
  }
  
}


