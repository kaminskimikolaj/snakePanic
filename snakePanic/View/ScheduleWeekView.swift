//
//  ScheduleWeekView.swift
//  snakePanic
//
//  Created by Mikołaj Kamiński on 26/11/2019.
//  Copyright © 2019 Mikołaj Kamiński. All rights reserved.
//

import UIKit

class ScheduleWeekView: UIViewController {

    var views = [UIView]()
    var constraints = [Widths]()
    
    struct Widths {
        let standardWidth: NSLayoutConstraint
        let featuredWidth: NSLayoutConstraint
        let superWidth: NSLayoutConstraint
        let zeroWidth: NSLayoutConstraint
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        if constraints[selected].superWidth.isActive {
//            constraints[selected].superWidth.isActive = false
//            constraints[selected].featuredWidth.isActive = true
//            for i in 0...4 {
//                if selected != i {
//                    constraints[i].zeroWidth.isActive = false
//                    constraints[i].standardWidth.isActive = true
//                }
//            }
//            UIView.animate(withDuration: 0.25) {
//                self.view.layoutIfNeeded()
//            }
//        } else {
//            //TODO: setup selected according to displayed data
//        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        
        setupScroll()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tap(sender:)))
        tap.numberOfTapsRequired = 1
        view.addGestureRecognizer(tap)
    }

    let scroll = UIScrollView(frame: .zero)
    func setupScroll() {
        view.addSubview(scroll)
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scroll.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor).isActive = true
        scroll.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scroll.contentSize = CGSize(width: view.frame.width * 2 - 1, height: scroll.frame.height)
        scroll.bounces = false
        scroll.delegate = self
    }
    
    @objc func tap(sender:UITapGestureRecognizer){

        if sender.state == .ended {
            
            var touchLocation: CGPoint = sender.location(in: sender.view)
            let array = self.views.map({ $0.frame.contains(touchLocation) })
            for index in 0...4 {
                if array[index] {
                    if index == selected {
                        superWidth(index: index)
                        break;
                    } else {
                        self.scroll.setContentOffset(CGPoint(x: 320 - touchLocation.x, y: 0), animated: true)
                    }
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
        }, completion: { (_: Bool) in
            let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.diselect(sender:)))
            tap.numberOfTapsRequired = 2
            self.views[index].addGestureRecognizer(tap)
            self.scroll.isHidden = true

        })
    }
    
    @objc func diselect(sender: UITapGestureRecognizer) {
        print(selected)
        constraints[selected].superWidth.isActive = false
        constraints[selected].featuredWidth.isActive = true
        for i in 0...4 {
            if selected != i {
                constraints[i].zeroWidth.isActive = false
                constraints[i].standardWidth.isActive = true
            }
        }
        UIView.animate(withDuration: 0.25, animations: {
            self.view.layoutIfNeeded()
        }, completion: { bool in
            self.scroll.isHidden = false
        })
//        sender.view?.removeGestureRecognizer(tap)
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
    
    func setupViews() {
        for i in 0...4 {
            let subview = UIView(frame: .zero)
            subview.backgroundColor = UIColor.palette()[i + 2]
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
}

extension ScheduleWeekView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pos = scrollView.contentOffset.x + 1
        let value = 4 - selected
        if pos / 64 - CGFloat(value) > 1 {
            selected -= 1
        }
        if CGFloat(value) - pos / 64 > 0 {
            selected += 1
        }
    }
}
