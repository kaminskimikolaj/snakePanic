//
//  YellowViewController.swift
//  snakePanic
//
//  Created by Mikołaj Kamiński on 05/12/2019.
//  Copyright © 2019 Mikołaj Kamiński. All rights reserved.
//

import UIKit

class YellowViewController: UIViewController {

//    override func viewDidLoad() {
        
//        super.viewDidLoad()
//
//        let scroll = UIScrollView(frame: view.safeAreaLayoutGuide.layoutFrame)
//        view.addSubview(scroll)
//
//        let subview = UIView(frame: .zero)
//        subview.backgroundColor = .systemTeal
//        scroll.addSubview(subview)
//        subview.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            subview.topAnchor.constraint(equalTo: scroll.topAnchor),
//            subview.heightAnchor.constraint(equalTo: scroll.heightAnchor, multiplier: 2),
//            subview.widthAnchor.constraint(equalTo: scroll.widthAnchor),
//            subview.leftAnchor.constraint(equalTo: scroll.leftAnchor)
//        ])
//        print(subview.bounds.size)
//        scroll.contentSize = subview.bounds.size
//
//        let bar1 = UIView(frame: .zero)
//        bar1.backgroundColor = .systemGreen
//        subview.addSubview(bar1)
//        bar1.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            bar1.topAnchor.constraint(equalTo: subview.topAnchor),
//            bar1.heightAnchor.constraint(equalTo: subview.heightAnchor, multiplier: 1/10),
//            bar1.widthAnchor.constraint(equalTo: subview.widthAnchor)
//        ])
//
//        let bar2 = UIView(frame: .zero)
//        bar2.backgroundColor = .systemBlue
//        subview.addSubview(bar2)
//        bar2.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            bar2.bottomAnchor.constraint(equalTo: subview.bottomAnchor),
//            bar2.heightAnchor.constraint(equalTo: subview.heightAnchor, multiplier: 1/10),
//            bar2.widthAnchor.constraint(equalTo: subview.widthAnchor)
//        ])
//
//    }

    let setup: UILabel = {
        let label = UILabel()
//        label.text = "Scroll Bottom"
//        label.backgroundColor = .green
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let scrollView: UIScrollView = {
        let v = UIScrollView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .systemOrange
        return v
    }()


    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(scrollView)
        scrollView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true

        scrollView.addSubview(setup)
        let frame = view.safeAreaLayoutGuide.layoutFrame
        let constant = frame.height * 2
        setup.leftAnchor.constraint(equalTo: scrollView.leftAnchor).isActive = true
        setup.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: constant).isActive = true
        setup.rightAnchor.constraint(equalTo: scrollView.rightAnchor).isActive = true
        setup.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        
        let subview = UIView(frame: .zero)
        subview.backgroundColor = .systemTeal
        scrollView.addSubview(subview)
        subview.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            subview.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            subview.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 2),
            subview.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            subview.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor)
        ])
    }

}
