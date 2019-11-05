//
//  ScheduleWeekTest.swift
//  snakePanic
//
//  Created by Mikołaj Kamiński on 30/10/2019.
//  Copyright © 2019 Mikołaj Kamiński. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

    var views = [UIView]()
    var constaints = [Widths]()
    
    struct Widths {
        let standardWidth: NSLayoutConstraint
        let featuredWidth: NSLayoutConstraint
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let scroll = UIScrollView(frame: .zero)
        setupViews()
        registerSwipeGestures()
    }
    
    var lastSelected: Int = 0
    var selected: Int = 0 {
        didSet {
            NSLayoutConstraint.deactivate([constaints[lastSelected].featuredWidth, constaints[self.selected].standardWidth])
            NSLayoutConstraint.activate([constaints[self.selected].featuredWidth, constaints[lastSelected].standardWidth])
            
            UIView.animate(withDuration: 0.25) {
                self.view.layoutIfNeeded()
            }
            lastSelected = self.selected
        }
    }
    
    func setupViews() {
        for i in 0...4 {
            let subview = UIView(frame: .zero)
            subview.backgroundColor = UIColor.palette()[i]
            views.append(subview)
            view.addSubview(subview)
            subview.translatesAutoresizingMaskIntoConstraints = false
            subview.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            subview.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
            if i == 0 {
                subview.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
            } else {
                subview.leftAnchor.constraint(equalTo: views[i - 1].rightAnchor).isActive = true
            }
            let widths = Widths(standardWidth: subview.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 2/11), featuredWidth: subview.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 3/11))
            if selected == i {
                widths.featuredWidth.isActive = true
            } else {
                widths.standardWidth.isActive = true
            }
            constaints.append(widths)
        }
    }
     
    func registerSwipeGestures() {
         let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
         swipeLeft.direction = .left
         self.view.addGestureRecognizer(swipeLeft)

         let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
         swipeRight.direction = .right
         self.view.addGestureRecognizer(swipeRight)
     }
     
     @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
         if gesture.direction == .right {
             if selected > 0 {
                 selected -= 1
             }
         }
         else if gesture.direction == .left {
             if selected < 4 {
                 selected += 1
             }
         }
     }
}


extension UIColor {
  class func colorFromRGB(_ r: Int, g: Int, b: Int) -> UIColor {
    return UIColor(red: CGFloat(Float(r) / 255), green: CGFloat(Float(g) / 255), blue: CGFloat(Float(b) / 255), alpha: 1)
  }
  
  class func palette() -> [UIColor] {
    let palette = [
      UIColor.colorFromRGB(85, g: 0, b: 255),
      UIColor.colorFromRGB(170, g: 0, b: 170),
      UIColor.colorFromRGB(85, g: 170, b: 85),
      UIColor.colorFromRGB(0, g: 85, b: 0),
      UIColor.colorFromRGB(255, g: 170, b: 0),
      UIColor.colorFromRGB(255, g: 255, b: 0),
      UIColor.colorFromRGB(255, g: 85, b: 0),
      UIColor.colorFromRGB(0, g: 85, b: 85),
      UIColor.colorFromRGB(0, g: 85, b: 255),
      UIColor.colorFromRGB(170, g: 170, b: 255),
      UIColor.colorFromRGB(85, g: 0, b: 0),
      UIColor.colorFromRGB(170, g: 85, b: 85),
      UIColor.colorFromRGB(170, g: 255, b: 0),
      UIColor.colorFromRGB(85, g: 170, b: 255),
      UIColor.colorFromRGB(0, g: 170, b: 170)
    ]
    return palette
  }
}
