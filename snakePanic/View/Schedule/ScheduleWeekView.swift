//
//  ScheduleView.swift
//  snakePanic
//
//  Created by Mikołaj Kamiński on 05/12/2019.
//  Copyright © 2019 Mikołaj Kamiński. All rights reserved.
//

import UIKit

class ScheduleWeekView: UIViewController {

    var horizontalRows = [ScheduleDayView]()
    var horizontalRowsWidths = [HorizontalRowWidth]()
    
    lazy var doubleTap = UIShortTapGestureRecognizer(target: self, action: #selector(self.handleDoubleTap(sender:)))
    lazy var pan = UIPanTouchDownGestureRecognizer(target: self, action: #selector(handlePan(sender:)))
    lazy var singleTap = UITapGestureRecognizer(target: self, action: #selector(handleSingleTap(sender:)))
    
    let barView = UIView(frame: .zero)
    let textView = UILabel(frame: .zero)
    let rightButton = UIView(frame: .zero)
//    var isRightButtonSelected = false {
//        didSet {
//            if self.isRightButtonSelected {
//                rightButton.backgroundColor = .systemTeal
//            } else {
//                rightButton.backgroundColor = .systemBlue
//            }
//        }
//    }
//
    var lastSelected: Int = 4
    var selected: Int = 4 {
        didSet {
            NSLayoutConstraint.deactivate([horizontalRowsWidths[lastSelected].featuredWidth, horizontalRowsWidths[self.selected].standardWidth])
            NSLayoutConstraint.activate([horizontalRowsWidths[self.selected].featuredWidth, horizontalRowsWidths[lastSelected].standardWidth])
            self.horizontalRows[self.selected].backgroundColor = .systemGray4
            self.horizontalRows[lastSelected].backgroundColor = .systemGray6
            self.horizontalRows[self.selected].layer.cornerRadius = 5
            self.horizontalRows[lastSelected].layer.cornerRadius = 0
            UIView.animate(withDuration: 0.25) {
                self.view.layoutIfNeeded()
            }
            lastSelected = self.selected
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        barView.backgroundColor = .systemGray6
        barView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(barView)
        NSLayoutConstraint.activate([
            barView.widthAnchor.constraint(equalTo: view.widthAnchor),
            barView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            barView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 1/12)
        ])

        textView.text = "2020-02-10 - 2020-02-16"
        textView.textColor = .systemGray
        textView.adjustsFontSizeToFitWidth = true
        textView.textAlignment = .center
        barView.addSubview(textView)
        textView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: barView.topAnchor),
            textView.heightAnchor.constraint(equalTo: barView.heightAnchor),
            textView.widthAnchor.constraint(equalTo: barView.widthAnchor, multiplier: 4/5),
            textView.centerXAnchor.constraint(equalTo: barView.centerXAnchor)
        ])
        barView.addSubview(rightButton)
        rightButton.backgroundColor = .systemTeal
//        rightButton.addTarget(self, action: #selector(handleRightButtonTap(sender:)), for: .touchUpInside)
        rightButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            rightButton.leftAnchor.constraint(equalTo: textView.rightAnchor),
            rightButton.rightAnchor.constraint(equalTo: barView.rightAnchor),
            rightButton.heightAnchor.constraint(equalTo: barView.heightAnchor)
        ])
        
//        let image = UIImage(named: "button37d2")
//        let imageView = UIImageView(image: image!)
//        imageView.frame = CGRect(x: width/5, y: height/5, width: 19.2, height: 24.95)
//        rightButton.addSubview(imageView)
        
        setupViews()
        view.backgroundColor = .systemGray6
        view.addGestureRecognizer(pan)
    }
    
    var beganPanLocation: Int?
    var endedPanLocation: Int?
    
    @objc func handlePan(sender: UIPanTouchDownGestureRecognizer) {
//        print("handling pan")
        if !(self.rightButton.frame.contains(sender.location(in: self.view))) {
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
        } else {
            textView.text = "2020-02-17 - 2020-02-21"
//            if isRightButtonSelected {
//                isRightButtonSelected = false
//            } else {
//                isRightButtonSelected = true
//            }
            
        }
    }
    
    @objc func handleDoubleTap(sender: UITapGestureRecognizer) {
        print("handlingDoubleTap")
        self.horizontalRows[self.selected].scrollingEnabled = false
        self.horizontalRows[self.selected].selected = 0
//        self.view.removeGestureRecognizer(doubleTap)
        self.view.removeGestureRecognizer(singleTap)
        self.view.addGestureRecognizer(pan)
        featuredWidth()
    }
    
    @objc func handleSingleTap(sender: UITapGestureRecognizer) {
        print("handling single tap")
        let cellHeight = self.horizontalRows[self.selected].frame.height / 10
        let location = sender.location(in: self.horizontalRows[selected]).y
        for i in 0...9 {
            if self.horizontalRows[selected].cells[i].frame.minY < location && self.horizontalRows[selected].cells[i].frame.maxY > location {
                var newOffset = cellHeight * CGFloat(i)
                if i != 9 {
                    newOffset += 25
                }
                self.horizontalRows[self.selected].setContentOffset(CGPoint(x: 0, y: newOffset), animated: true)
//                print("selected: \(i)")
                self.horizontalRows[self.selected].selected = i
            }
        }
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
//            horizontalRow.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            horizontalRow.topAnchor.constraint(equalTo: barView.bottomAnchor).isActive = true
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
                horizontalRow.layer.cornerRadius = 5
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
                self.horizontalRows[i].layer.cornerRadius = 5
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
//                self.horizontalRows[i].layer.cornerRadius = 0
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
        self.horizontalRows[self.selected].scrollingEnabled = true
//        self.horizontalRows[self.selected].selected = 0
        for i in 0...4 {
            if selected == i {
                self.horizontalRowsWidths[i].featuredWidth.isActive = false
                self.horizontalRowsWidths[i].superWidth.isActive = true
                self.horizontalRows[i].layer.cornerRadius = 0
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
            
            self.singleTap.require(toFail: self.doubleTap)
            self.singleTap.cancelsTouchesInView = false
            self.view.addGestureRecognizer(self.singleTap)
            
            self.horizontalRows[self.selected].setupTopAnchorConstraintsForWeekView.isActive = false
            self.horizontalRows[self.selected].setupTopAnchorConstraintsForDayView.isActive = true
        })
    }
    
    var doonce = true
    override func viewDidLayoutSubviews() {

        if doonce {
            doonce = false
            let height = view.safeAreaLayoutGuide.layoutFrame.height / 12
            let width = view.frame.width / 10

            let safeHeight = height * 3/5
            let safeWidth = width * 3/5

//            let image = UIImage(named: "button37d2")
            let image = UIImage(systemName: "chevron.right", withConfiguration: UIImage.SymbolConfiguration(pointSize: 16, weight: .bold))
//            image = image?.withTintColor(.systemGray2)
            let imageView = UIImageView(image: image!)
            imageView.image?.withRenderingMode(.alwaysTemplate)
            imageView.tintColor = .systemOrange
            imageView.frame = CGRect(x: width/5, y: height/5, width: safeWidth, height: safeHeight)
            rightButton.addSubview(imageView)
        }
    }
}

class UIPanTouchDownGestureRecognizer: UIPanGestureRecognizer {

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        if (self.state == UIGestureRecognizer.State.began) { return }
        super.touchesBegan(touches, with: event)
        self.state = UIGestureRecognizer.State.began
    }
}

//class UITouchDownTap: UITapGestureRecognizer {
//
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
//        if (self.state == UIGestureRecognizer.State.began) { return }
//        super.touchesBegan(touches, with: event)
//        self.state = UIGestureRecognizer.State.began
//    }
//}
class UIShortTapGestureRecognizer: UITapGestureRecognizer {
    let tapMaxDelay: Double = 0.3

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesBegan(touches, with: event)

        DispatchQueue.main.asyncAfter(deadline: .now() + tapMaxDelay) { [weak self] in
            if self?.state != UIGestureRecognizer.State.recognized {
                self?.state = UIGestureRecognizer.State.failed
            }
        }
    }
}


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
