//
//  YellowViewController.swift
//  snakePanic
//
//  Created by Mikołaj Kamiński on 05/12/2019.
//  Copyright © 2019 Mikołaj Kamiński. All rights reserved.
//

import UIKit

class YellowViewController: UIViewController {

    lazy var subview = UIView(frame: view.frame)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        subview.backgroundColor = .systemTeal
        view.addSubview(subview)
        
        let singleTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleSingleTap(sender:)))
        singleTapGesture.numberOfTapsRequired = 1
        subview.addGestureRecognizer(singleTapGesture)

//        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleDounbleTap(sender:)))
        let doubleTapGesture = UIShortTapGestureRecognizer(target: self, action: #selector(handleDounbleTap(sender:)))
        doubleTapGesture.numberOfTapsRequired = 2
//        doubleTapGesture.
        subview.addGestureRecognizer(doubleTapGesture)
        
        singleTapGesture.require(toFail: doubleTapGesture)
    }
    
    @objc func handleDounbleTap(sender: UITapGestureRecognizer) {
        print("double tap")
        self.subview.backgroundColor = .systemTeal
    }
    
    @objc func handleSingleTap(sender: UITapGestureRecognizer) {
//        print("single tap")
        NSLog("single tap")
        self.subview.backgroundColor = .systemBlue
    }
    
    
//    let setup: UILabel = {
//        let label = UILabel(frame: .zero)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//
//    let scrollView: UIScrollView = {
//        let v = UIScrollView(frame: .zero)
//        v.translatesAutoresizingMaskIntoConstraints = false
//        v.backgroundColor = .systemOrange
//        return v
//    }()
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        view.addSubview(scrollView)
//        scrollView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
//        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
//        scrollView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
//        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
//
//        scrollView.addSubview(setup)
//        let frame = view.safeAreaLayoutGuide.layoutFrame
//        let constant = frame.height * 2
//        setup.leftAnchor.constraint(equalTo: scrollView.leftAnchor).isActive = true
//        setup.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: constant).isActive = true
//        setup.rightAnchor.constraint(equalTo: scrollView.rightAnchor).isActive = true
//        setup.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
//    }

}

//class UIShortTapGestureRecognizer: UITapGestureRecognizer {
//    let tapMaxDelay: Double = 0.25
//
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
//        super.touchesBegan(touches, with: event)
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + tapMaxDelay) { [weak self] in
//            if self?.state != UIGestureRecognizer.State.recognized {
//                self?.state = UIGestureRecognizer.State.failed
//            }
//        }
//    }
//}


