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

        view.backgroundColor = .systemYellow
        let scroll = UIScrollView(frame: .zero)
        scroll.backgroundColor = .systemGreen
        view.addSubview(scroll)
        scroll.contentSize = CGSize(width: view.frame.width, height: view.frame.height * 2)
        scroll.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scroll.topAnchor.constraint(equalTo: view.topAnchor),
            scroll.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 2),
            scroll.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
        let box = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        box.backgroundColor = .systemRed
        scroll.addSubview(box)
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
