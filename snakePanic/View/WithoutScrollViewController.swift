//
//  WithoutScrollViewController.swift
//  snakePanic
//
//  Created by Mikołaj Kamiński on 05/12/2019.
//  Copyright © 2019 Mikołaj Kamiński. All rights reserved.
//

import UIKit

class WithoutScrollViewController: UIViewController {

    let subview = UIView(frame: .zero)
    var views = [UIView]()
    var constraints = [Widths]()
    
    struct Widths {
        let standardWidth: NSLayoutConstraint
        let featuredWidth: NSLayoutConstraint
        let superWidth: NSLayoutConstraint
        let zeroWidth: NSLayoutConstraint
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        view.addSubview(subview)
        subview.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            subview.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            subview.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            subview.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor),
            subview.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor)
        ])
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan(sender:)))
        subview.addGestureRecognizer(pan)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        subview.addGestureRecognizer(tap)
    }
    
    func setupViews() {
        for i in 0...4 {
            let subview = UIView(frame: .zero)
            if i % 2 == 0 { subview.backgroundColor = #colorLiteral(red: 0.737254902, green: 0.0431372549, blue: 0.6, alpha: 1) } else { subview.backgroundColor = #colorLiteral(red: 0.0431372549, green: 0.5058823529, blue: 0.737254902, alpha: 1) }
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
            let widths = Widths(standardWidth: subview.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 2/11), featuredWidth: subview.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 3/11), superWidth: subview.widthAnchor.constraint(equalTo: view.widthAnchor), zeroWidth: subview.widthAnchor.constraint(equalToConstant: 0.0))
            if selected == i {
                widths.featuredWidth.isActive = true
            } else {
                widths.standardWidth.isActive = true
            }
            constraints.append(widths)
        }
    }
    
    lazy var screenWidth = view.frame.width

    @objc func handlePan(sender: UIPanGestureRecognizer) {
        let location = sender.location(in: self.subview).x
        if sender.state == .began {
            if location < self.views[selected].frame.minX || location > self.views[selected].frame.maxX {
                sender.setTranslation(CGPoint(x: 0, y: 0), in: self.subview)
            }
        }
        if sender.state != .began {
            if location > self.views[selected].frame.maxX {
                sender.setTranslation(CGPoint(x: 0, y: 0), in: self.subview)
                if selected < 4 {
                    selected += 1
                }
            }
            if location < self.views[selected].frame.minX {
                sender.setTranslation(CGPoint(x: 0, y: 0), in: self.subview)
                if selected > 0 {
                    selected -= 1
                }
            }
        }
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer) {
        let location = sender.location(in: self.subview).x
        for i in 0...4 {
            if self.views[i].frame.minX < location && self.views[i].frame.maxX > location {
                if selected == i {
                    superWidth(index: i)
                } else {
                    selected = i
                }
            }
        }
    }
    
    func superWidth(index: Int) {
        for i in 0...4 {
            if index == i {
                self.constraints[i].featuredWidth.isActive = false
                self.constraints[i].superWidth.isActive = true
            } else {
                self.constraints[i].standardWidth.isActive = false
                self.constraints[i].zeroWidth.isActive = true
            }
        }
        UIView.animate(withDuration: 0.25, animations: {
            self.view.layoutIfNeeded()
        }, completion: { _ in
            
        })
    }
    
    var lastSelected: Int = 4
    var selected: Int = 4 {
        didSet {
            NSLayoutConstraint.deactivate([constraints[lastSelected].featuredWidth, constraints[self.selected].standardWidth])
            NSLayoutConstraint.activate([constraints[self.selected].featuredWidth, constraints[lastSelected].standardWidth])

            UIView.animate(withDuration: 0.25) {
                self.view.layoutIfNeeded()
            }
            lastSelected = self.selected
        }
    }
}
