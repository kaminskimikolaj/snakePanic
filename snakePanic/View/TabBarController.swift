//
//  UITabBarController.swift
//  snakePanic
//
//  Created by Mikołaj Kamiński on 01/12/2019.
//  Copyright © 2019 Mikołaj Kamiński. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.delegate = self
        self.tabBar.tintColor = .systemTeal
        self.viewControllers = [prototype2, prototype1]
        
        let appearance = tabBar.standardAppearance
        appearance.shadowColor = nil
        appearance.backgroundColor = .systemGray6
        tabBar.standardAppearance = appearance
    }
    
    
    lazy public var prototype1: UIViewController = {
//        let prototype1 = YellowViewController()
        let prototype1 = TopBarTestViewController()
//        let prototype1 = UINavigationController(rootViewController: YellowViewController())
//        prototype1.isNavigationBarHidden = true
        prototype1.tabBarItem = UITabBarItem(title: "Prototype 1", image: UIImage(named: "Schedule"), tag: 0)
        return prototype1
    }()
    
    lazy public var prototype2: UIViewController = {
        let prototype2 = ScheduleWeekView()
//        prototype2.isNavigationBarHidden = true
        prototype2.tabBarItem = UITabBarItem(title: "Prototype 2", image: UIImage(named: "Map"), tag: 1)
        
        return prototype2
    }()
}
