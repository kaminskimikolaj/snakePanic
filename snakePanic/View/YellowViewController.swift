////
////  YellowViewController.swift
////  snakePanic
////
////  Created by Mikołaj Kamiński on 05/12/2019.
////  Copyright © 2019 Mikołaj Kamiński. All rights reserved.
////
//
//import UIKit
//
//class YellowViewController: UIViewController {
//
//    lazy var subview = UIView(frame: view.frame)
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        subview.backgroundColor = .systemTeal
//        view.addSubview(subview)
//
//        let singleTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleSingleTap(sender:)))
//        singleTapGesture.numberOfTapsRequired = 1
//        subview.addGestureRecognizer(singleTapGesture)
//
////        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleDounbleTap(sender:)))
//        let doubleTapGesture = UIShortTapGestureRecognizer(target: self, action: #selector(handleDounbleTap(sender:)))
//        doubleTapGesture.numberOfTapsRequired = 2
////        doubleTapGesture.
//        subview.addGestureRecognizer(doubleTapGesture)
//
//        singleTapGesture.require(toFail: doubleTapGesture)
//    }
//
//    @objc func handleDounbleTap(sender: UITapGestureRecognizer) {
//        print("double tap")
//        self.subview.backgroundColor = .systemTeal
//    }
//
//    @objc func handleSingleTap(sender: UITapGestureRecognizer) {
////        print("single tap")
//        NSLog("single tap")
//        self.subview.backgroundColor = .systemBlue
//    }
//
//
////    let setup: UILabel = {
////        let label = UILabel(frame: .zero)
////        label.translatesAutoresizingMaskIntoConstraints = false
////        return label
////    }()
////
////    let scrollView: UIScrollView = {
////        let v = UIScrollView(frame: .zero)
////        v.translatesAutoresizingMaskIntoConstraints = false
////        v.backgroundColor = .systemOrange
////        return v
////    }()
////
////
////    override func viewDidLoad() {
////        super.viewDidLoad()
////
////        view.addSubview(scrollView)
////        scrollView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
////        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
////        scrollView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
////        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
////
////        scrollView.addSubview(setup)
////        let frame = view.safeAreaLayoutGuide.layoutFrame
////        let constant = frame.height * 2
////        setup.leftAnchor.constraint(equalTo: scrollView.leftAnchor).isActive = true
////        setup.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: constant).isActive = true
////        setup.rightAnchor.constraint(equalTo: scrollView.rightAnchor).isActive = true
////        setup.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
////    }
//
//}
//
////class UIShortTapGestureRecognizer: UITapGestureRecognizer {
////    let tapMaxDelay: Double = 0.25
////
////    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
////        super.touchesBegan(touches, with: event)
////
////        DispatchQueue.main.asyncAfter(deadline: .now() + tapMaxDelay) { [weak self] in
////            if self?.state != UIGestureRecognizer.State.recognized {
////                self?.state = UIGestureRecognizer.State.failed
////            }
////        }
////    }
////}
//
//


import UIKit

class YellowViewController: UIViewController {

//    let barView = UIView(frame: .zero)
//    let textView = UILabel(frame: .zero)
//    let rightButton = UIView(frame: .zero)
//
//    override func viewDidLoad() {
//        barView.backgroundColor = .systemGray2
//        barView.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(barView)
//        NSLayoutConstraint.activate([
//            barView.widthAnchor.constraint(equalTo: view.widthAnchor),
//            barView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            barView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 1/12)
//        ])
//
//        textView.text = "test test test test test test test test test test test"
//        textView.adjustsFontSizeToFitWidth = true
//        textView.textAlignment = .center
//        barView.addSubview(textView)
//        textView.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            textView.topAnchor.constraint(equalTo: barView.topAnchor),
//            textView.heightAnchor.constraint(equalTo: barView.heightAnchor),
//            textView.widthAnchor.constraint(equalTo: barView.widthAnchor, multiplier: 4/5),
//            textView.centerXAnchor.constraint(equalTo: barView.centerXAnchor)
//        ])
//        barView.addSubview(rightButton)
//        rightButton.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            rightButton.leftAnchor.constraint(equalTo: textView.rightAnchor),
//            rightButton.rightAnchor.constraint(equalTo: barView.rightAnchor),
//            rightButton.heightAnchor.constraint(equalTo: barView.heightAnchor)
//        ])
//    }
//
//    override func viewDidLayoutSubviews() {
//
//        let height = view.safeAreaLayoutGuide.layoutFrame.height / 12
//        let width = view.frame.width / 10
//
//        let safeHeight = height * 3/5
//        let safeWidth = width * 3/5
//
//        let image = UIImage(named: "button37d2")
//        let imageView = UIImageView(image: image!)
//        imageView.frame = CGRect(x: width/5, y: height/5, width: safeWidth, height: safeHeight)
//        rightButton.addSubview(imageView)
//    }

    let container = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 1000))
    var lastTranslation: CGFloat = 0
    var height: CGFloat = 0
    
    @objc func action(sender: UIPanGestureRecognizer) {

        if sender.state == .began { lastTranslation = 0 }
        let translation = sender.translation(in: container).y
        print(translation, container.frame.origin.y, sender.state.rawValue)
        if container.frame.origin.y + (translation - lastTranslation) > 0 {
            container.frame.origin.y = 0
//            print(container.frame.origin.y)
        } else if 1000 + container.frame.origin.y + (translation - lastTranslation) < height {
//            print("now")
            container.frame.origin.y = -(1000 - height)
        } else {
            container.frame.origin.y += (translation - lastTranslation)
            lastTranslation = translation
            print(container.frame.origin.y)
        }
        
//        if !(container.frame.origin.y + (translation - lastTranslation) > 0) && !(1000 + container.frame.origin.y + (translation - lastTranslation) < height) {
//            container.frame.origin.y += (translation - lastTranslation)
//            lastTranslation = translation
//            print(container.frame.origin.y)
//        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        height = self.view.frame.height - (self.tabBarController?.tabBar.frame.height)!
//        print(view.frame.height)
        print(height)
        view.backgroundColor = .systemBlue
//        container.backgroundColor = .systemBlue
        view.addSubview(container)
        
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(action(sender:)))
        container.addGestureRecognizer(panGesture)
        

        
        
        var subviews = [UIView]()
        
        for i in 0...9 {
            let subview = UIView(frame: .zero)
            if i % 2 == 0 {
                subview.backgroundColor = .systemPink
            } else {
                subview.backgroundColor = .systemOrange
            }
            subview.translatesAutoresizingMaskIntoConstraints = false
            container.addSubview(subview)
            subviews.append(subview)
            
            if i == 0 {
                subview.topAnchor.constraint(equalTo: container.topAnchor).isActive = true
            } else {
//                print(subviews)
                subview.topAnchor.constraint(equalTo: subviews[i - 1].bottomAnchor).isActive = true
            }
            subview.widthAnchor.constraint(equalTo: container.widthAnchor).isActive = true
            subview.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: 1/10).isActive = true
        }
    }
}
