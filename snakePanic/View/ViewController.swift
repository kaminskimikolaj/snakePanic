//
//  ViewController.swift
//  sip2po
//
//  Created by Mikołaj Kamiński on 05/09/2019.
//  Copyright © 2019 Mikołaj Kamiński. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
//        let scrollView = UIScrollView(frame: .zero)
//        view.addSubview(scrollView)
//        scrollView.translatesAutoresizingMaskIntoConstraints = false
////        scrollView.frame = view.safeAreaLayoutGuide.layoutFrame
//        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
//        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
//        scrollView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
//        scrollView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
//        scrollView.backgroundColor = .systemGray
//
//        let testView = UIView()
//        var cells = [UIView]()
//        for i in 1...10 {
//            let cell = UIView(frame: .zero)
//            testView.addSubview(cell)
//            cell.translatesAutoresizingMaskIntoConstraints = false
////            cell.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true
//            cell.widthAnchor.constraint(equalTo: testView.widthAnchor).isActive = true
//            cell.heightAnchor.constraint(equalToConstant: 300.0)
//            if i == 1 {
//                cell.topAnchor.constraint(equalTo: testView.topAnchor).isActive = true
//            } else {
//                cell.topAnchor.constraint(equalTo: cells.last!.bottomAnchor).isActive = true
//            }
//            cells.append(cell)
//            if i % 2 == 0 {
//                cell.backgroundColor = .white
//            } else {
//                cell.backgroundColor = .black
//            }
//        }
//
//
//        scrollView.addSubview(testView)
        
//        

//        var vStack = [[UIView]]()
//        var vStackViews = [UIView]()
//        for v in 1...5 {
//            let hStackView = UIView(frame: .zero)
//            var hStack = [UIView]()
//            view.addSubview(hStackView)
////            hStackView.anchor(widthMultiplier: 1/5, heightMulplier: 1)
//            hStackView.translatesAutoresizingMaskIntoConstraints = false
//            hStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
//            hStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
//            hStackView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 1/6).isActive = true
//            if v == 1 { hStackView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true }
//            else { hStackView.leftAnchor.constraint(equalTo: vStackViews.last!.rightAnchor).isActive = true }
////            hStackView.backgroundColor = .systemPink
//            vStackViews.append(hStackView)
//            for h in 1...8 {
//                let cell = UIView(frame: .zero)
//                hStackView.addSubview(cell)
//                cell.translatesAutoresizingMaskIntoConstraints = false
//                cell.widthAnchor.constraint(equalTo: hStackView.widthAnchor).isActive = true
//                cell.heightAnchor.constraint(equalTo: hStackView.heightAnchor, multiplier: 1/8).isActive = true
//                if h == 1 { cell.topAnchor.constraint(equalTo: hStackView.topAnchor).isActive = true }
//                else { cell.topAnchor.constraint(equalTo: hStack.last!.bottomAnchor).isActive = true }
//                hStack.append(cell)
//                cell.backgroundColor = .white
//            }
//            vStack.append(hStack)
//        }
//
//        for (vIndex, v) in vStack.enumerated() {
//            for (hIndex, h) in v.enumerated() {
//                if vIndex == 4 && hIndex == 7 {
//                    h.backgroundColor = .systemBlue
//                }
//                if vIndex == 0 && hIndex == 0 {
//                    h.backgroundColor = .systemGreen
//                }
//            }
//        }
        scrapLessonScheduleAndSave()
    }
    
    func scrapLessonScheduleAndSave() {
        let semaphore = DispatchSemaphore(value: 0)
        DispatchQueue.global(qos: .background).async {
            do { try HttpsScrapper().login(user: "S45_AR4Q5848168", pass: "c9VYgL4R") { result in
                print(result)
                semaphore.signal()
            }}
            catch let error { print(error) }
            semaphore.wait()

            do { try HttpsScrapper().scrapLessonsSchedule() { result in
                switch result {
                case .success(let data):
                    print(data)
                    let stack = CoreDataStack.sharedInstance
                    stack.saveContext()
                case .failure(let error):
                    print("Error: \(error)")
                }
                semaphore.signal()
            }}
            catch let error { print(error) }
        }
    }
}

extension UIView {
    
    func anchor(widthMultiplier: CGFloat = 1, heightMulplier: CGFloat = 1, top: Bool = false, bottom: Bool = false, left: Bool = false, right: Bool = false) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalTo: superview!.widthAnchor, multiplier: widthMultiplier).isActive = true
        heightAnchor.constraint(equalTo: superview!.heightAnchor, multiplier: heightMulplier).isActive = true
        
        if top == true {
            topAnchor.constraint(equalTo: superview!.topAnchor).isActive = true
        }
        if bottom == true {
            bottomAnchor.constraint(equalTo: superview!.bottomAnchor).isActive = true
        }
        if right == true {
            rightAnchor.constraint(equalTo: superview!.rightAnchor).isActive = true
        }
        if left == true {
            leftAnchor.constraint(equalTo: superview!.leftAnchor).isActive = true
        }
    }
    
    func makeCenter() {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        centerYAnchor.constraint(equalTo: superview!.centerYAnchor).isActive = true
        centerXAnchor.constraint(equalTo: superview!.centerXAnchor).isActive = true
    }
}
