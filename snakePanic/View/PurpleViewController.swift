//
//  PurpleViewController.swift
//  sip2po
//
//  Created by Mikołaj Kamiński on 26/10/2019.
//  Copyright © 2019 Mikołaj Kamiński. All rights reserved.
//

import UIKit

class PurpleViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPurple
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tabBarController?.viewControllers?[0].tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "List"), tag: 0)
        tabBarController?.selectedIndex = 0
    }
}
