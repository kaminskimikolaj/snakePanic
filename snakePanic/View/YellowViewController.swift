//
//  YellowViewController.swift
//  snakePanic
//
//  Created by Mikołaj Kamiński on 05/12/2019.
//  Copyright © 2019 Mikołaj Kamiński. All rights reserved.
//

import UIKit

class YellowViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scroll = UIScrollView(frame: .zero)
        
        view.addSubview(scroll)
        scroll.backgroundColor = .systemPink
        scroll.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scroll.topAnchor.constraint(equalTo: view.topAnchor),
            scroll.heightAnchor.constraint(equalToConstant: 300),
            scroll.widthAnchor.constraint(equalToConstant: 300)
        ])
        
        
        scroll.contentSize = CGSize(width: 1000, height: 1000)
        
        
        let subview = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 320, height: 800))
        subview.backgroundColor = .systemGreen
        scroll.addSubview(subview)
        
        let box1 = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        box1.backgroundColor = .systemTeal
        subview.addSubview(box1)
        
        let box2 = UIView(frame: CGRect(x: 500, y: 200, width: 100, height: 100))
        box2.backgroundColor = .systemTeal
        subview.addSubview(box2)
    
//        let subview = UIView(frame: .zero)
//        subview.backgroundColor = .systemTeal
//        subview.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            subview.topAnchor.constraint(equalTo: view.topAnchor),
//            subview.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 2),
//            subview.widthAnchor.constraint(equalTo: view.widthAnchor)
//        ])
//        scroll.addSubview(subview)
//        scroll.contentSize = subview.bounds.size
        
//        view.backgroundColor = .systemYellow
//        let scroll = UIScrollView(frame: .zero)
//        scroll.backgroundColor = .systemGreen
//        view.addSubview(scroll)
//        scroll.contentSize = CGSize(width: view.frame.width, height: view.frame.height * 2)
//        scroll.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            scroll.topAnchor.constraint(equalTo: view.topAnchor),
//            scroll.heightAnchor.constraint(equalTo: view.heightAnchor),
//            scroll.widthAnchor.constraint(equalTo: view.widthAnchor)
//        ])
//        let box = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
//        box.backgroundColor = .systemRed
//        scroll.addSubview(box)
//        box.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//           box.bottomAnchor.constraint(equalTo: scroll.bottomAnchor)
//       ])
//
//        let box2 = UIView(frame: .zero)
//        box2.backgroundColor = .systemBlue
//        scroll.addSubview(box2)
//        box2.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            box2.bottomAnchor.constraint(equalTo: scroll.bottomAnchor),
//            box2.heightAnchor.constraint(equalTo: scroll.heightAnchor, multiplier: 1/10),
//            box2.widthAnchor.constraint(equalTo: scroll.widthAnchor)
//        ])
        // Do any additional setup after loading the view.
    }

}
