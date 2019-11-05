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

        window = UIWindow(frame: UIScreen.main.bounds)
        
        let tabBarController = UITabBarController()
        tabBarController.tabBar.tintColor = .systemTeal
        tabBarController.tabBar.barTintColor = .systemGroupedBackground
        
        let navigationController = UINavigationController(rootViewController: ScheduleDayCollectionController())
//        let flowLayout = UICollectionViewFlowLayout()
//        flowLayout.scrollDirection = .vertical
//        flowLayout.minimumInteritemSpacing = 5.0
//
//        let navigationController = UINavigationController(rootViewController: ScheduleWeekHorizontalCollectionView(collectionViewLayout: flowLayout))

        navigationController.isNavigationBarHidden = true
        navigationController.tabBarItem = UITabBarItem(title: "Schedule", image: UIImage(named: "Schedule"), tag: 0)
        
        let pinkViewController = PinkViewController()
//        let pinkViewController = TestViewController2()
        pinkViewController.tabBarItem = UITabBarItem(title: "Marks", image: UIImage(named: "Map"), tag: 1)
        
        tabBarController.viewControllers = [navigationController, pinkViewController]
        window?.rootViewController = tabBarController
        
//        window?.rootViewController = ViewController()
        window?.makeKeyAndVisible()
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        print(urls[urls.count-1] as URL)
        return true
    }
}
