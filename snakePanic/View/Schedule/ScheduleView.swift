//
//  ScheduleView.swift
//  snakePanic
//
//  Created by Mikołaj Kamiński on 05/12/2019.
//  Copyright © 2019 Mikołaj Kamiński. All rights reserved.
//

import UIKit

class ScheduleView: UIViewController {

    var horizontalRows = [ScheduleDayView]()
    var horizontalRowsWidths = [HorizontalRowWidth]()
    
    lazy var doubleTap = UITapGestureRecognizer(target: self, action: #selector(self.handlDoubleTap(sender:)))
    lazy var pan = PanTouchDownGestureRecognizer(target: self, action: #selector(handleTest(sender:)))
    
    var lastSelected: Int = 4
    var selected: Int = 4 {
        didSet {
            NSLayoutConstraint.deactivate([horizontalRowsWidths[lastSelected].featuredWidth, horizontalRowsWidths[self.selected].standardWidth])
            NSLayoutConstraint.activate([horizontalRowsWidths[self.selected].featuredWidth, horizontalRowsWidths[lastSelected].standardWidth])
            self.horizontalRows[self.selected].backgroundColor = .systemGray4
            self.horizontalRows[lastSelected].backgroundColor = .systemGray6
            UIView.animate(withDuration: 0.25) {
                self.view.layoutIfNeeded()
            }
            lastSelected = self.selected
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
        view.backgroundColor = .systemGray6
        view.addGestureRecognizer(pan)
    }
    
    var beganPanLocation: Int?
    var endedPanLocation: Int?
    
    @objc func handleTest(sender: PanTouchDownGestureRecognizer) {
        let location = sender.location(in: self.view).x
        var selectedIndex = Int()
        for i in 0...4 {
            if self.horizontalRows[i].frame.minX < location && location < self.horizontalRows[i].frame.maxX {
                selectedIndex = i
            }
        }

        if location < self.horizontalRows[selected].frame.minX || location > self.horizontalRows[selected].frame.maxX {
            self.selected = selectedIndex
            beganPanLocation = nil
            endedPanLocation = nil
        } else {
            if sender.state == .began { beganPanLocation = selectedIndex }
            if sender.state == .ended { endedPanLocation = selectedIndex }
            
            if sender.state == .ended && beganPanLocation == endedPanLocation && beganPanLocation != nil {
                superWidth()
                beganPanLocation = nil
                endedPanLocation = nil
            }
        }
    }
    
    @objc func handlDoubleTap(sender: UITapGestureRecognizer) {
        self.view.removeGestureRecognizer(doubleTap)
        self.view.addGestureRecognizer(pan)
        featuredWidth()
    }
    
    struct HorizontalRowWidth {
        let standardWidth: NSLayoutConstraint
        let featuredWidth: NSLayoutConstraint
        let superWidth: NSLayoutConstraint
        let zeroWidth: NSLayoutConstraint
    }
    
    func setupViews() {
        for i in 0...4 {
            let horizontalRow = ScheduleDayView(frame: .zero)
            horizontalRow.setupTopAnchorConstraintsForWeekView = horizontalRow.setup.topAnchor.constraint(equalTo: horizontalRow.topAnchor)
            horizontalRow.setupTopAnchorConstraintsForWeekView.isActive = true
            let height = self.view.frame.height - UIApplication.shared.statusBarFrame.height - (self.tabBarController?.tabBar.frame.height)!
            horizontalRow.setupTopAnchorConstraintsForDayView = horizontalRow.setup.topAnchor.constraint(equalTo: horizontalRow.topAnchor, constant: height * 2)
 
            horizontalRows.append(horizontalRow)
            view.addSubview(horizontalRow)
            horizontalRow.translatesAutoresizingMaskIntoConstraints = false
            horizontalRow.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            horizontalRow.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
            if i == 0 {
                horizontalRow.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
            } else {
                horizontalRow.leftAnchor.constraint(equalTo: horizontalRows[i - 1].rightAnchor).isActive = true
            }
            let widths = HorizontalRowWidth(standardWidth: horizontalRow.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 2/11), featuredWidth: horizontalRow.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 3/11), superWidth: horizontalRow.widthAnchor.constraint(equalTo: view.widthAnchor), zeroWidth: horizontalRow.widthAnchor.constraint(equalToConstant: 0.0))
            
            if selected == i {
                widths.featuredWidth.isActive = true
                horizontalRow.backgroundColor = .systemGray4
            } else {
                widths.standardWidth.isActive = true
            }
            horizontalRowsWidths.append(widths)
        }
    }
    
    func featuredWidth() {
        for i in 0...4 {
            if selected == i {
                self.horizontalRowsWidths[i].superWidth.isActive = false
                self.horizontalRowsWidths[i].featuredWidth.isActive = true
                for ii in 0...9 {
                    if ii == self.horizontalRows[i].selected {
                        self.horizontalRows[i].cellsConstraints[ii].dayFeaturedHeight.isActive = false
                    } else {
                        self.horizontalRows[i].cellsConstraints[ii].dayStandardHeight.isActive = false
                    }
                    self.horizontalRows[i].cellsConstraints[ii].weekHeight.isActive = true
                }
            } else {
                self.horizontalRowsWidths[i].zeroWidth.isActive = false
                self.horizontalRowsWidths[i].standardWidth.isActive = true
            }
        }
        self.horizontalRows[self.selected].setupTopAnchorConstraintsForDayView.isActive = false
        self.horizontalRows[self.selected].setupTopAnchorConstraintsForWeekView.isActive = true
        UIView.animate(withDuration: 0.25, animations: {
            self.view.layoutIfNeeded()
        }, completion: { _ in
            
        })
    }
    
    func superWidth() {
        for i in 0...4 {
            if selected == i {
                self.horizontalRowsWidths[i].featuredWidth.isActive = false
                self.horizontalRowsWidths[i].superWidth.isActive = true
                for ii in 0...9 {
                    self.horizontalRows[i].cellsConstraints[ii].weekHeight.isActive = false
                    if ii == self.horizontalRows[i].selected {
                        self.horizontalRows[i].cellsConstraints[ii].dayFeaturedHeight.isActive = true
                    } else {
                        self.horizontalRows[i].cellsConstraints[ii].dayStandardHeight.isActive = true
                    }
                }
            } else {
                self.horizontalRowsWidths[i].standardWidth.isActive = false
                self.horizontalRowsWidths[i].zeroWidth.isActive = true
            }
        }
        UIView.animate(withDuration: 0.25, animations: {
            self.view.layoutIfNeeded()
        }, completion: { _ in
            self.view.removeGestureRecognizer(self.pan)
            
            self.doubleTap.numberOfTapsRequired = 2
            self.view.addGestureRecognizer(self.doubleTap)
            
            self.horizontalRows[self.selected].setupTopAnchorConstraintsForWeekView.isActive = false
            self.horizontalRows[self.selected].setupTopAnchorConstraintsForDayView.isActive = true
        })
    }
}

class PanTouchDownGestureRecognizer: UIPanGestureRecognizer {

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        if (self.state == UIGestureRecognizer.State.began) { return }
        super.touchesBegan(touches, with: event)
        self.state = UIGestureRecognizer.State.began
    }

}
