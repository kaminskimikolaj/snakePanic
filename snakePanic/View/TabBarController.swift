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
        
//        setup()
//        self.view.backgroundColor = .systemBlue
        self.tabBarController?.delegate = self
        self.tabBar.tintColor = .systemTeal
        self.tabBar.barTintColor = .systemGroupedBackground
        self.viewControllers = [prototype2, prototype1]
    }
    
    
    lazy public var prototype1: UINavigationController = {
        //        let prototype1 = UINavigationController(rootViewController: ScheduleDayCollectionController())
        let prototype1 = UINavigationController(rootViewController: ScheduleWeekView())
        prototype1.isNavigationBarHidden = true
        prototype1.tabBarItem = UITabBarItem(title: "Prototype 1", image: UIImage(named: "Schedule"), tag: 0)
        return prototype1
    }()
    
    lazy public var prototype2: UINavigationController = {
        let prototype2 = UINavigationController(rootViewController: WithoutScrollViewController())
        prototype2.isNavigationBarHidden = true
        prototype2.tabBarItem = UITabBarItem(title: "Prototype 2", image: UIImage(named: "Map"), tag: 1)
        
        return prototype2
    }()
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        print(tabBar, item)
    }
//    func setup() {
//        self.view.backgroundColor = .systemBlue
//        self.tabBarController?.delegate = self
//        tabBarController?.tabBar.tintColor = .systemTeal
//        tabBarController?.tabBar.barTintColor = .systemGroupedBackground
//        let prototype1 = UINavigationController(rootViewController: ScheduleDayCollectionController())
//        prototype1.isNavigationBarHidden = true
//        prototype1.tabBarItem = UITabBarItem(title: "Prototype 1", image: UIImage(named: "Schedule"), tag: 0)
//
//        let prototype2 = UINavigationController(rootViewController: ScheduleWeekView())
//        prototype2.isNavigationBarHidden = true
//        prototype2.tabBarItem = UITabBarItem(title: "Prototype 2", image: UIImage(named: "Map"), tag: 1)
//
//        tabBarController?.viewControllers = [prototype1, prototype2]
//    }

}
