//
//  ButtonViewController.swift
//  snakePanic
//
//  Created by Mikołaj Kamiński on 26/11/2019.
//  Copyright © 2019 Mikołaj Kamiński. All rights reserved.
//

import UIKit

class OrangeViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let subview = UIButton(frame: .zero)
        subview.backgroundColor = .systemTeal
        view.addSubview(subview)
        subview.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            subview.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            subview.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            subview.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            subview.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
        ])

        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tap(sender:)))
        tap.numberOfTapsRequired = 2
        view.addGestureRecognizer(tap)
        
    }
    
    @objc func tap(sender: UITapGestureRecognizer) {
        navigationController?.popViewController(animated: false)
    }
}
