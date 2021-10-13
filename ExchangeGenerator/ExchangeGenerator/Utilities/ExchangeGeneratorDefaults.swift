//
//  ExchangeGeneratorDefaults.swift
//  ExchangeGenerator
//
//  Created by Tundzhay Dzhansaz on 13.10.2021.
//

import Foundation
import UIKit

//MARK: - Created an enumeration for project default fonts
enum SFProDisplayFonts : String {
  case semibold = "SFProDisplay-Semibold"
  case bold = "SFProDisplay-Bold"
  case medium = "SFProDisplay-Medium"
  case regular = "SFProDisplay-Regular"
}

class ExchangeGenerator {
  static func systemFontOfSize(fontName: String, fontSize: CGFloat) -> UIFont {
    return UIFont(name: fontName, size: fontSize)!
  }
  
  static func createUILabel(font: UIFont, text: String?, textColor: UIColor, textAligment: NSTextAlignment, numberOfLines: Int) -> UILabel {
    let label = UILabel()
    label.font = font
    label.text = text
    label.textColor = textColor
    label.textAlignment = textAligment
    label.numberOfLines = numberOfLines
    label.translatesAutoresizingMaskIntoConstraints = false
    
    return label
  }
  
  static func makeViewIconWithTintColor(setImage: UIImage, setImageColor: UIColor) -> UIView {
    let imageView = UIImageView(image: setImage)
    imageView.setImageColor(color: setImageColor)
    return imageView
  }
}
