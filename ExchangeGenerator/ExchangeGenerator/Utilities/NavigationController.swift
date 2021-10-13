//
//  NavigationController.swift
//  ExchangeGenerator
//
//  Created by Tundzhay Dzhansaz on 13.10.2021.
//

import UIKit

class NavigationController: UINavigationController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let navigationTurnBack = UIImage(named: "BackButton")!
    let navigationTurnBackButtonInset = UIEdgeInsets(top: 0, left: -Device.alignToScreenWidth(percent: 3), bottom: 0, right: 0)
    
    if #available(iOS 13.0, *) {
      let appearance = UINavigationBarAppearance()
      appearance.backgroundColor = UIColor(named: "NavigationBarBackground")!
      appearance.titleTextAttributes = [.foregroundColor: UIColor(named: "NavigationBarText")!]
      appearance.largeTitleTextAttributes = [.foregroundColor: UIColor(named: "NavigationBarText")!]
      
      UINavigationBar.appearance().tintColor = UIColor(named: "NavigationBarText")!
      UINavigationBar.appearance().standardAppearance = appearance
      UINavigationBar.appearance().compactAppearance = appearance
      UINavigationBar.appearance().scrollEdgeAppearance = appearance
      
      appearance.setBackIndicatorImage(navigationTurnBack.withAlignmentRectInsets(navigationTurnBackButtonInset), transitionMaskImage: navigationTurnBack.withAlignmentRectInsets(navigationTurnBackButtonInset))
    }
    else {
      UINavigationBar.appearance().barTintColor = UIColor(named: "NavigationBarBackground")!
      UINavigationBar.appearance().tintColor = UIColor(named: "NavigationBarText")!
      UINavigationBar.appearance().isTranslucent = false
    }
    
    
    if #available(iOS 13.0, *) {
      let appearence = UITabBarAppearance()
      appearence.backgroundColor = UIColor(named: "NavigationBarBackground")!
      
      UITabBar.appearance().tintColor = .white
      UITabBar.appearance().standardAppearance = appearence
    }
    else {
      UITabBar.appearance().tintColor = .white
      UITabBar.appearance().barTintColor = UIColor(named: "NavigationBarBackground")!
      UITabBar.appearance().isTranslucent = false
    }
    
  }
}

