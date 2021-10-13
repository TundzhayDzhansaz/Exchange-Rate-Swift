//
//  HRCCell.swift
//  ExchangeGenerator
//
//  Created by Tundzhay Dzhansaz on 13.10.2021.
//

import UIKit


class HRCCell: UITableViewCell {
  
  //MARK:- Label Object
  let currencyNameLabel = ExchangeGenerator.createUILabel(font: ExchangeGenerator.systemFontOfSize(fontName: SFProDisplayFonts.semibold.rawValue, fontSize: 18), text: nil, textColor: .black, textAligment: .left, numberOfLines: 0)
  
  let currencyPriceLabel = ExchangeGenerator.createUILabel(font: ExchangeGenerator.systemFontOfSize(fontName: SFProDisplayFonts.regular.rawValue, fontSize: 15), text: nil, textColor: .black, textAligment: .left, numberOfLines: 0)
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupMVCCell()
  }
      
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
    
    
  func setupMVCCell(){
    self.selectionStyle = .none
    let selectedBackgroundImage = UIView()
    selectedBackgroundImage.backgroundColor = UIColor(named: "CellSelectedBackground")!.withAlphaComponent(0.5)
    self.selectedBackgroundView = selectedBackgroundImage
    
    addSubview(currencyNameLabel)
    currencyNameLabel.anchors(topAnchor: self.topAnchor, paddingTop: 0, leftAnchor: self.leftAnchor, paddingLeft: Device.alignToScreenWidth(percent: 5), rightAnchor: nil, paddingRight: 0, bottomAnchor: self.bottomAnchor, paddingBottom: 0, centerXAnchor: nil, paddingXAnchor: 0, centerYAnchor: self.centerYAnchor, paddingYAnchor: 0)
    currencyNameLabel.widthAnchor.constraint(equalToConstant: Device.alignToScreenWidth(percent: 20)).isActive = true
    
    addSubview(currencyPriceLabel)
    currencyPriceLabel.anchors(topAnchor: self.topAnchor, paddingTop: 0, leftAnchor: currencyNameLabel.rightAnchor, paddingLeft: Device.alignToScreenWidth(percent: 1), rightAnchor: self.rightAnchor, paddingRight: 0, bottomAnchor: self.bottomAnchor, paddingBottom: 0, centerXAnchor: nil, paddingXAnchor: 0, centerYAnchor: self.centerYAnchor, paddingYAnchor: 0)
  }
  
  func bindData(historicalData: Historical){
    currencyNameLabel.text = "\(String(describing: historicalData.base)) :"
    currencyPriceLabel.text = "\(String(describing: historicalData.rates))"
  }
}




