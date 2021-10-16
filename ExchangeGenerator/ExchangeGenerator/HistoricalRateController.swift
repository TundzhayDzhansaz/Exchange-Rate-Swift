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
  
  
  fileprivate let startDateLabel = ExchangeGenerator.createUILabel(font: ExchangeGenerator.systemFontOfSize(fontName: SFProDisplayFonts.semibold.rawValue, fontSize: 15), text: "Start Date: ", textColor: .black, textAligment: .center, numberOfLines: 0)
  
  fileprivate let endDateLabel = ExchangeGenerator.createUILabel(font: ExchangeGenerator.systemFontOfSize(fontName: SFProDisplayFonts.semibold.rawValue, fontSize: 15), text: "End Date: ", textColor: .black, textAligment: .center, numberOfLines: 0)
  
  
  //when you start to choose a date with date pickers, you will see there some constraint error. Don't care it. just create a text view and set the datepicker as a input view.
  fileprivate var startingDatePicker: UIDatePicker = {
    let datePicker = UIDatePicker()
    
    datePicker.datePickerMode = .date
    datePicker.backgroundColor = UIColor(named: "CellBackground")!
    datePicker.translatesAutoresizingMaskIntoConstraints = false
    
    let currentDate: Date = Date()
    var calendar: Calendar = Calendar(identifier: Calendar.Identifier.gregorian)
    calendar.locale = Locale(identifier: "en_US_POSIX")
    calendar.timeZone = TimeZone(identifier: "UTC")!
    var components: DateComponents = DateComponents()
    components.calendar = calendar
    components.month = -1
    let maxDate: Date = calendar.date(byAdding: components, to: currentDate)!
    components.year = -1
    let minDate: Date = calendar.date(byAdding: components, to: currentDate)!
    components.month = -1
    //let lastYear: Date = calendar.date(byAdding: components, to: currentDate)!

    datePicker.minimumDate = minDate
    datePicker.maximumDate = maxDate
    
    let lastYearCurrentDate: Date = Date()
    var lastYearCalendar: Calendar = Calendar(identifier: Calendar.Identifier.gregorian)
    lastYearCalendar.timeZone = TimeZone(identifier: "UTC")!
    var lastYearComponents: DateComponents = DateComponents()
    lastYearComponents.calendar = lastYearCalendar
    lastYearComponents.year = -1
    let lastYear: Date = lastYearCalendar.date(byAdding: lastYearComponents, to: lastYearCurrentDate)!
    datePicker.date = lastYear
    datePicker.addTarget(self, action: #selector(dateSetter), for: .valueChanged)
    return datePicker
  }()
  
  fileprivate var endDatePicker: UIDatePicker = {
    let datePicker = UIDatePicker()
    
    datePicker.datePickerMode = .date
    datePicker.backgroundColor = UIColor(named: "CellBackground")!
    datePicker.translatesAutoresizingMaskIntoConstraints = false
    
    let currentDate: Date = Date()
    var calendar: Calendar = Calendar(identifier: Calendar.Identifier.gregorian)
    calendar.locale = Locale(identifier: "en_US_POSIX")
    calendar.timeZone = TimeZone(identifier: "UTC")!
    var components: DateComponents = DateComponents()
    components.calendar = calendar
    components.day = 0
    let maxDate: Date = calendar.date(byAdding: components, to: currentDate)!
    components.month = -1
    components.day = 1
    let minDate: Date = calendar.date(byAdding: components, to: currentDate)!
    components.day = 1
    //let lastYear: Date = calendar.date(byAdding: components, to: currentDate)!

    datePicker.minimumDate = minDate
    datePicker.maximumDate = maxDate
    datePicker.addTarget(self, action: #selector(dateSetter), for: .valueChanged)
    
    return datePicker
  }()
  
  @objc func dateSetter(){
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    dateFormatter.string(from: startingDatePicker.date)
    
    fetchHistoricalData(startDate: "\(dateFormatter.string(from: startingDatePicker.date))", endDate: "\(dateFormatter.string(from: endDatePicker.date))")
    self.tableView.reloadData()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    setupTableView()
    dateSetter()
    print("\(startingDatePicker.date) - \(endDatePicker.date)")
    
    baseCurrencyLabel.text = "USD • \(currencyName)"
    baseCurrencyInfoLabel.text = "RealTime: \(currencyPrice)"
    
    
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
    
    view.addSubview(startDateLabel)
    startDateLabel.anchors(topAnchor: baseCurrencyInfoLabel.bottomAnchor, paddingTop: Device.alignToScreenWidth(percent: 1), leftAnchor: view.leftAnchor, paddingLeft: Device.alignToScreenWidth(percent: 5), rightAnchor: view.centerXAnchor, paddingRight: 0, bottomAnchor: nil, paddingBottom: 0, centerXAnchor: nil, paddingXAnchor: 0, centerYAnchor: nil, paddingYAnchor: 0)
    startDateLabel.heightAnchor.constraint(equalToConstant: Device.alignToScreenWidth(percent: 10)).isActive = true
    
    view.addSubview(startingDatePicker)
    startingDatePicker.anchors(topAnchor: baseCurrencyInfoLabel.bottomAnchor, paddingTop: Device.alignToScreenWidth(percent: 1), leftAnchor: startDateLabel.rightAnchor, paddingLeft: Device.alignToScreenWidth(percent: 1), rightAnchor: view.rightAnchor, paddingRight: 0, bottomAnchor: nil, paddingBottom: 0, centerXAnchor: nil, paddingXAnchor: 0, centerYAnchor: nil, paddingYAnchor: 0)
    startingDatePicker.heightAnchor.constraint(equalToConstant: Device.alignToScreenWidth(percent: 10)).isActive = true
    
    view.addSubview(endDateLabel)
    endDateLabel.anchors(topAnchor: startDateLabel.bottomAnchor, paddingTop: Device.alignToScreenWidth(percent: 2), leftAnchor: view.leftAnchor, paddingLeft: Device.alignToScreenWidth(percent: 5), rightAnchor: view.centerXAnchor, paddingRight: 0, bottomAnchor: nil, paddingBottom: 0, centerXAnchor: nil, paddingXAnchor: 0, centerYAnchor: nil, paddingYAnchor: 0)
    endDateLabel.heightAnchor.constraint(equalToConstant: Device.alignToScreenWidth(percent: 10)).isActive = true
    
    view.addSubview(endDatePicker)
    endDatePicker.anchors(topAnchor: startDateLabel.bottomAnchor, paddingTop: Device.alignToScreenWidth(percent: 2), leftAnchor: endDateLabel.rightAnchor, paddingLeft: Device.alignToScreenWidth(percent: 1), rightAnchor: view.rightAnchor, paddingRight: 0, bottomAnchor: nil, paddingBottom: 0, centerXAnchor: nil, paddingXAnchor: 0, centerYAnchor: nil, paddingYAnchor: 0)
    
    view.addSubview(tableView)
    NSLayoutConstraint.activate([tableView.topAnchor.constraint(equalTo: endDateLabel.bottomAnchor),
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
  func fetchHistoricalData(startDate: String, endDate: String) {
    historicalCurrencies.removeAll()
    let exchangerateAPI_URL = "https://api.exchangerate.host/timeseries?start_date=\(startDate)&end_date=\(endDate)&base=USD"
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
        
        guard let rates = dict["rates"] as? [String : [String: Double]], let base = dict["base"] as? String else { return }
        
        let arrangeDate = rates.keys.sorted { $0 > $1 }.map{ $0 }
        
        for dateData in arrangeDate {
          if let rate = rates[dateData] {
            //print(dateData)
            
            for (key, value) in rate {
              //print(key, value)
              if key == self.currencyName {
                let createHistoricalData = Historical(base: "\(key)", rates: "\(value) | \(dateData)")
                self.historicalCurrencies.append(createHistoricalData)
              }
            }
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


