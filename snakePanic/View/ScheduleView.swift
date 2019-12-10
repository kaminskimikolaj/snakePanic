//
//  WithoutScrollViewController.swift
//  snakePanic
//
//  Created by Mikołaj Kamiński on 05/12/2019.
//  Copyright © 2019 Mikołaj Kamiński. All rights reserved.
//

import UIKit

class ScheduleView: UIViewController {

    let gestureTarget = UIView(frame: .zero)
    var horizontalRows = [HorizontalRow]()
    var horizontalRowsWidths = [HorizontalRowWidth]()

    struct HorizontalRowWidth {
        let standardWidth: NSLayoutConstraint
        let featuredWidth: NSLayoutConstraint
        let superWidth: NSLayoutConstraint
        let zeroWidth: NSLayoutConstraint
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        printValues()
        setupViews()
        view.backgroundColor = .systemGray6
//        view.addSubview(gestureTarget)
//        gestureTarget.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            gestureTarget.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
//            gestureTarget.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
//            gestureTarget.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor),
//            gestureTarget.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor)
//        ])
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan(sender:)))
//        gestureTarget.addGestureRecognizer(pan)
        view.addGestureRecognizer(pan)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
//        gestureTarget.addGestureRecognizer(tap)
        view.addGestureRecognizer(tap)

        
    }
    
    func printValues() {
        print(view.safeAreaInsets)
        print(view.safeAreaLayoutGuide)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        printValues()
    }
    
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        print("now")
    }
    
    func setupViews() {
        for i in 0...4 {
            let horizontalRow = HorizontalRow(frame: .zero)
            horizontalRow.setupTopAnchorConstraintsForWeekView = horizontalRow.setup.topAnchor.constraint(equalTo: horizontalRow.topAnchor)
            horizontalRow.setupTopAnchorConstraintsForWeekView.isActive = true
            let height = self.view.frame.height - UIApplication.shared.statusBarFrame.height - (self.tabBarController?.tabBar.frame.height)!
            horizontalRow.setupTopAnchorConstraintsForDayView = horizontalRow.setup.topAnchor.constraint(equalTo: horizontalRow.topAnchor, constant: height * 2)
                    
            
//            print(view.frame.height)
//            print(view.safeAreaInsets.top)
//            print(view.safeAreaInsets.bottom)
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
//            let heights = HorizontalRowHeight(
//                weekHeight: horizontalRow.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor),
//                dayHeight: horizontalRow.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 2)
//            )
//            heights.weekHeight.isActive = true
//            horizontalRowsHeights.append(heights)
            
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
    
    lazy var screenWidth = view.frame.width

    @objc func handlePan(sender: UIPanGestureRecognizer) {
//        let location = sender.location(in: self.gestureTarget).x
        let location = sender.location(in: self.view).x
        if sender.state == .began {
            if location < self.horizontalRows[selected].frame.minX || location > self.horizontalRows[selected].frame.maxX {
//                sender.setTranslation(CGPoint(x: 0, y: 0), in: self.gestureTarget)
                sender.setTranslation(CGPoint(x: 0, y: 0), in: self.view)
            }
        }
        if sender.state != .began {
            if location > self.horizontalRows[selected].frame.maxX {
//                sender.setTranslation(CGPoint(x: 0, y: 0), in: self.gestureTarget)
                sender.setTranslation(CGPoint(x: 0, y: 0), in: self.view)
                if selected < 4 {
                    selected += 1
                }
            }
            if location < self.horizontalRows[selected].frame.minX {
//                sender.setTranslation(CGPoint(x: 0, y: 0), in: self.gestureTarget)
                sender.setTranslation(CGPoint(x: 0, y: 0), in: self.view)
                if selected > 0 {
                    selected -= 1
                }
            }
        }
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer) {
        let location = sender.location(in: self.view).x
        for i in 0...4 {
            if self.horizontalRows[i].frame.minX < location && self.horizontalRows[i].frame.maxX > location {
                if selected == i {
                    superWidth()
                } else {
                    selected = i
                }
            }
        }
    }
    
    @objc func handlDoubleTap(sender: UITapGestureRecognizer) {
        self.view.removeGestureRecognizer(doubleTap)
        featuredWidth()
    }
    
    func featuredWidth() {
        for i in 0...4 {
            if selected == i {
                self.horizontalRowsWidths[i].superWidth.isActive = false
                self.horizontalRowsWidths[i].featuredWidth.isActive = true
                for ii in 0...9 {
                    self.horizontalRows[i].cellsConstraints[ii].dayHeight.isActive = false
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
    
    lazy var doubleTap = UITapGestureRecognizer(target: self, action: #selector(self.handlDoubleTap(sender:)))
    
    func superWidth() {
//        print(self.horizontalRows[selected].contentSize)
        for i in 0...4 {
            if selected == i {
                self.horizontalRowsWidths[i].featuredWidth.isActive = false
                self.horizontalRowsWidths[i].superWidth.isActive = true
                for ii in 0...9 {
                    self.horizontalRows[i].cellsConstraints[ii].weekHeight.isActive = false
                    self.horizontalRows[i].cellsConstraints[ii].dayHeight.isActive = true
                }
            } else {
                self.horizontalRowsWidths[i].standardWidth.isActive = false
                self.horizontalRowsWidths[i].zeroWidth.isActive = true
            }
        }
        UIView.animate(withDuration: 0.25, animations: {
            self.view.layoutIfNeeded()
        }, completion: { _ in
            self.doubleTap.numberOfTapsRequired = 2
            self.view.addGestureRecognizer(self.doubleTap)
            
            self.horizontalRows[self.selected].setupTopAnchorConstraintsForWeekView.isActive = false
            self.horizontalRows[self.selected].setupTopAnchorConstraintsForDayView.isActive = true
        })
    }
    
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
}

//class HorizontalRow: UIScrollView {
//
//    let contentView = UIView(frame: .zero)
//    var cells = [UIView]()
//    var cellsConstraints = [CellHeight]()
//
//    struct CellHeight {
//        let weekHeight: NSLayoutConstraint
//        let dayHeight: NSLayoutConstraint
//    }
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupView()
//    }
//
//    private func setupView() {
//        layer.cornerRadius = 5
//        backgroundColor = .systemGray6
//        for i in 0...9 {
//            let cell = UIView(frame: .zero)
//            contentView.addSubview(cell)
//            cells.append(cell)
//            cell.translatesAutoresizingMaskIntoConstraints = false
//            NSLayoutConstraint.activate([
//                cell.widthAnchor.constraint(equalTo: widthAnchor),
//                cell.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1/10)
//            ])
//            if i == 0 {
//                cell.topAnchor.constraint(equalTo: topAnchor).isActive = true
//            } else {
//                cell.topAnchor.constraint(equalTo: cells[i - 1].bottomAnchor).isActive = true
//            }
//            let heights = CellHeight(
//                weekHeight: cell.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1/10),
//                dayHeight: cell.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1/5))
////            if isSuperWidthed {
////                heights.dayHeight.isActive = true
////                print("didn't believe that'd be ever called")
////            } else {
//                heights.weekHeight.isActive = true
////            }
//            self.cellsConstraints.append(heights)
//
//
//            let subCell = UIView(frame: .zero)
//            subCell.backgroundColor = .systemGray2
//            subCell.layer.cornerRadius = 5
//            cell.addSubview(subCell)
//            subCell.translatesAutoresizingMaskIntoConstraints = false
//            NSLayoutConstraint.activate([
//                subCell.widthAnchor.constraint(equalTo: cell.widthAnchor, multiplier: 9/10),
//                subCell.heightAnchor.constraint(equalTo: cell.heightAnchor, multiplier: 9/10),
//                subCell.centerXAnchor.constraint(equalTo: cell.centerXAnchor),
//                subCell.centerYAnchor.constraint(equalTo: cell.centerYAnchor)
//            ])
//        }
//        let setup = UIView(frame: .zero)
//        addSubview(setup)
////        let frame = view.safeAreaLayoutGuide.layoutFrame
////        let constant = frame.height * 2
//        setup.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
//        setup.topAnchor.constraint(equalTo: self.topAnchor, constant: 500).isActive = true
//        setup.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
//        setup.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
//        addSubview(self.contentView)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}


class HorizontalRow: UIScrollView {
    
    var cells = [UIView]()
    var setup = UIView(frame: .zero)
    var setupTopAnchorConstraintsForWeekView = NSLayoutConstraint()
    var setupTopAnchorConstraintsForDayView = NSLayoutConstraint()
    var cellsConstraints = [CellHeight]()

    struct CellHeight {
        let weekHeight: NSLayoutConstraint
        let dayHeight: NSLayoutConstraint
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .systemGray6
        addSubview(setup)
        setup.translatesAutoresizingMaskIntoConstraints = false
        setup.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        setup.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        setup.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
//        self.setupTopAnchorConstraint = setup.topAnchor.constraint(equalTo: self.topAnchor)
//        self.setupTopAnchorConstraint.isActive = true
        
        for i in 0...9 {
            let cell = UIView(frame: .zero)
            addSubview(cell)
            cell.translatesAutoresizingMaskIntoConstraints = false
            cell.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
//            NSLayoutConstraint.activate([
//                cell.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1/10),
//
//            ])
            if i == 0 {
                cell.topAnchor.constraint(equalTo: topAnchor).isActive = true
            } else {
                cell.topAnchor.constraint(equalTo: cells[i - 1].bottomAnchor).isActive = true
            }
            let heights = CellHeight(
                weekHeight: cell.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1/10),
                dayHeight: cell.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1/5))
            heights.weekHeight.isActive = true
            self.cellsConstraints.append(heights)
            cells.append(cell)

            let contentCell = UIView(frame: .zero)
            if i % 2 == 0 {
                contentCell.backgroundColor = .systemTeal
            } else {
                contentCell.backgroundColor = .systemGreen
            }
            cell.addSubview(contentCell)
            contentCell.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                contentCell.heightAnchor.constraint(equalTo: cell.heightAnchor, multiplier: 9/10),
                contentCell.widthAnchor.constraint(equalTo: cell.widthAnchor, multiplier: 9/10),
                contentCell.centerXAnchor.constraint(equalTo: cell.centerXAnchor),
                contentCell.centerYAnchor.constraint(equalTo: cell.centerYAnchor)
            ])
        }
    }
}
