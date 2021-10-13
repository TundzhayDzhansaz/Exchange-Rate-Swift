//
//  MainViewController.swift
//  ExchangeGenerator
//
//  Created by Tundzhay Dzhansaz on 13.10.2021.
//

import Foundation
import UIKit
import Alamofire

class MainViewController : UIViewController {
  
  var receivedCurrencies: [Currency] = []
  let cellIdentifier = "MVCCell"
  let customCell = MVCCell()
  
  //MARK:- Variables of Shuffle View
  fileprivate var tableView: UITableView = {
    let tableView = UITableView(frame: CGRect.zero, style: UITableView.Style.plain)
    tableView.backgroundColor = .white
    tableView.rowHeight = Device.alignToScreenWidth(percent: 22)
    tableView.translatesAutoresizingMaskIntoConstraints = false
    return tableView
  }()
  
  fileprivate let baseCurrencyLabel = ExchangeGenerator.createUILabel(font: ExchangeGenerator.systemFontOfSize(fontName: SFProDisplayFonts.semibold.rawValue, fontSize: 32), text: "USD", textColor: .black, textAligment: .center, numberOfLines: 0)
  fileprivate let baseCurrencyInfoLabel = ExchangeGenerator.createUILabel(font: ExchangeGenerator.systemFontOfSize(fontName: SFProDisplayFonts.regular.rawValue, fontSize: 15), text: "Base Currency", textColor: .black, textAligment: .center, numberOfLines: 0)
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    
    setupTableView()
    fetchData(currencyBase: "USD")
    
    DispatchQueue.main.async {
      
    }
  }
  
  
  func setupTableView(){
    tableView.register(MVCCell.self, forCellReuseIdentifier: cellIdentifier)
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
  
  func handleShowHistoricalView(currencyName: String, currencyPrice: Double, date: String){
    let historicalView = HistoricalRateController(currencyName: currencyName, currencyPrice: currencyPrice, date: date)
    let navController = NavigationController(rootViewController: historicalView)
    navController.isModalInPresentation = true
    navController.modalPresentationStyle = .fullScreen
    present(navController, animated: true)
  }
  
}


//MARK:- Table View Data Source
extension MainViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return receivedCurrencies.count
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return Device.alignToScreenWidth(percent: 13)
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! MVCCell
    let currency = receivedCurrencies[indexPath.row]
    cell.bindData(currency: currency)
    return cell
  }
}


//MARK:- Table View Delegate
extension MainViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    let currencyName = receivedCurrencies[indexPath.row]
    //print(currencyName.base)
    self.handleShowHistoricalView(currencyName: currencyName.base, currencyPrice: currencyName.rates, date: "2021-09-09")
    //self.handleShowHistoricalRate(currencyName: "\(currencyName.base)", date: "2021-10-10")
  }
}


extension MainViewController {

  func fetchData(currencyBase: String) {
    let exchangerateAPI_URL = "https://api.exchangerate.host/latest?base=\(currencyBase)"
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
            let createData = Currency(base: "\(currency)", rates: rate)
            self.receivedCurrencies.append(createData)
            print(createData.base)
          }
        }
        
        DispatchQueue.main.async {
          self.tableView.reloadData()
        }

        
      }catch {
        print("some error")
      }
    }
    task.resume()
  }
}
