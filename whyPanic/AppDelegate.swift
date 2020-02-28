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
        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        print(paths[0])
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = TabBarController()
        window?.makeKeyAndVisible()
        
//        let defaults = UserDefaults.standard
//        let lastUpdate = ["LastUpdate" : ""]
//        defaults.register(defaults: lastUpdate)
        
        return true
    }
}
