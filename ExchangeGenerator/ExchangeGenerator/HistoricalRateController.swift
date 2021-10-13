//
//  HistoricalRateController.swift
//  ExchangeGenerator
//
//  Created by Tundzhay Dzhansaz on 13.10.2021.
//

import Foundation
import UIKit
class HistoricalRateController: UIViewController {
  
  var historicalCurrencies: [Historical] = []
  var currencyName = ""
  var currencyPrice = 0.0
  var date = ""
  
  init(currencyName: String, currencyPrice: Double, date: String) {
    super.init(nibName: nil, bundle: nil)
    
    self.currencyName = currencyName
    self.currencyPrice = currencyPrice
    self.date = date
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  
  let cellIdentifier = "HRCCell"
  //MARK:- Variables of Shuffle View
  fileprivate var tableView: UITableView = {
    let tableView = UITableView(frame: CGRect.zero, style: UITableView.Style.plain)
    tableView.backgroundColor = .white
    tableView.rowHeight = Device.alignToScreenWidth(percent: 22)
    tableView.translatesAutoresizingMaskIntoConstraints = false
    return tableView
  }()
  
  fileprivate let baseCurrencyLabel = ExchangeGenerator.createUILabel(font: ExchangeGenerator.systemFontOfSize(fontName: SFProDisplayFonts.semibold.rawValue, fontSize: 32), text: "USD •", textColor: .black, textAligment: .center, numberOfLines: 0)
  fileprivate let baseCurrencyInfoLabel = ExchangeGenerator.createUILabel(font: ExchangeGenerator.systemFontOfSize(fontName: SFProDisplayFonts.regular.rawValue, fontSize: 15), text: "Base Currency", textColor: .black, textAligment: .center, numberOfLines: 0)
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    setupTableView()
    fetchHistoricalData()
    
    baseCurrencyLabel.text = "EUR • \(currencyName)"
    baseCurrencyInfoLabel.text = "RealTime: \(currencyPrice)"
    
    
    
    DispatchQueue.main.async {
      
    }
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Dismiss", style: .plain, target: self, action: #selector(dismissSelf))
  }
  
  @objc private func dismissSelf(){
    dismiss(animated: true, completion: nil)
  }
  
  func setupTableView(){
    tableView.register(HRCCell.self, forCellReuseIdentifier: cellIdentifier)
    tableView.delegate = self
    tableView.dataSource = self
  
    view.addSubview(baseCurrencyLabel)
    
    baseCurrencyLabel.anchors(topAnchor: view.safeAreaLayoutGuide.topAnchor, paddingTop: 0, leftAnchor: view.leftAnchor, paddingLeft: 0, rightAnchor: view.rightAnchor, paddingRight: 0, bottomAnchor: nil, paddingBottom: 0, centerXAnchor: view.centerXAnchor, paddingXAnchor: 0, centerYAnchor: nil, paddingYAnchor: 0)
    baseCurrencyLabel.heightAnchor.constraint(equalToConstant: Device.alignToScreenWidth(percent: 20)).isActive = true
    
    view.addSubview(baseCurrencyInfoLabel)
    
    baseCurrencyInfoLabel.anchors(topAnchor: baseCurrencyLabel.bottomAnchor, paddingTop: -Device.alignToScreenWidth(percent: 5), leftAnchor: view.leftAnchor, paddingLeft: 0, rightAnchor: view.rightAnchor, paddingRight: 0, bottomAnchor: nil, paddingBottom: 0, centerXAnchor: view.centerXAnchor, paddingXAnchor: 0, centerYAnchor: nil, paddingYAnchor: 0)
    baseCurrencyInfoLabel.heightAnchor.constraint(equalToConstant: Device.alignToScreenWidth(percent: 10)).isActive = true
    
    
    view.addSubview(tableView)
    NSLayoutConstraint.activate([tableView.topAnchor.constraint(equalTo: baseCurrencyInfoLabel.bottomAnchor),
                                 tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                 tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                                 tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
  }
}


//MARK:- Table View Data Source
extension HistoricalRateController: UITableViewDataSource {
  
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

    return historicalCurrencies.count
  }
  
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return Device.alignToScreenWidth(percent: 13)
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! HRCCell

    let historicalData = historicalCurrencies[indexPath.row]
    cell.bindData(historicalData: historicalData)

    return cell
  }
}


//MARK:- Table View Delegate
extension HistoricalRateController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }
}


extension HistoricalRateController {
  func fetchHistoricalData() {
    let exchangerateAPI_URL = "https://api.exchangerate.host/\(date)"
    guard let url = URL(string: exchangerateAPI_URL) else { return }
    
    let task = URLSession.shared.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
      
      guard error == nil else { return }
      if let httpResponse = response as? HTTPURLResponse {
        guard httpResponse.statusCode == 200 else { return }
        print("good")
      }
      
      guard let data = data else { return }
      
      do {
        guard let dict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject] else { return }
        
        guard let rates = dict["rates"] as? [String: Double], let base = dict["base"] as? String, let date = dict["date"] as? String else { return }
    
        let currencies = rates.keys.sorted()
        //print(currencies)
    
        for currency in currencies {
          if let rate = rates[currency] {
            let createHistoricalData = Historical(base: "\(currency)", rates: rate)
            
            if currency == self.currencyName {
              print(base)
              self.historicalCurrencies.append(createHistoricalData)
            }
          }
        }
        DispatchQueue.main.async {
          self.tableView.reloadData()
        }
        print(rates)
      }catch {
        print("some error")
      }
    }
    task.resume()
  }
}
