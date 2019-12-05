//
//  AppDelegate.swift
//  sip2po
//
//  Created by Mikołaj Kamiński on 05/09/2019.
//  Copyright © 2019 Mikołaj Kamiński. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

//        UIApplication.shared.statusBar
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = TabBarController()
        window?.makeKeyAndVisible()
//        let flowLayout = UICollectionViewFlowLayout()
//        flowLayout.scrollDirection = .vertical
//        flowLayout.minimumInteritemSpacing = 5.0
//
//        let navigationController = UINavigationController(rootViewController: ScheduleWeekHorizontalCollectionView(collectionViewLayout: flowLayout))
        
//        let tabBarController = UITabBarController()
//        tabBarController.tabBar.tintColor = .systemTeal
//        tabBarController.tabBar.barTintColor = .systemGroupedBackground
//
//        let prototype1 = UINavigationController(rootViewController: ScheduleDayCollectionController())
//        prototype1.isNavigationBarHidden = true
//        prototype1.tabBarItem = UITabBarItem(title: "Prototype 1", image: UIImage(named: "Schedule"), tag: 0)
//
//        let prototype2 = UINavigationController(rootViewController: ScheduleWeekView())
//        prototype2.isNavigationBarHidden = true
//        prototype2.tabBarItem = UITabBarItem(title: "Prototype 2", image: UIImage(named: "Map"), tag: 1)
//
//        tabBarController.viewControllers = [prototype1, prototype2]
//        window?.rootViewController = tabBarController
//        window?.makeKeyAndVisible()
        
        
//        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
//        print(urls[urls.count-1] as URL)
        return true
    }
}
