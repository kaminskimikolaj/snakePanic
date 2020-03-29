//
//  ScheduleView.swift
//  snakePanic
//
//  Created by Mikołaj Kamiński on 05/12/2019.
//  Copyright © 2019 Mikołaj Kamiński. All rights reserved.
//

import UIKit

class ScheduleWeekView: UIViewController {
    
    struct HorizontalRowWidth {
        let standardWidth: NSLayoutConstraint
        let featuredWidth: NSLayoutConstraint
        let superWidth: NSLayoutConstraint
        let zeroWidth: NSLayoutConstraint
    }
    
    struct FontSzie {
        let weekStandardSize: UIFont
        let weekFeaturedSize: UIFont
        let dayStandardSize: UIFont
        let dayFeaturedSize: UIFont
    }
    
//    static let fontSize: FontSzie
    
    var horizontalRows = [ScheduleDayView]()
    var horizontalRowsWidths = [HorizontalRowWidth]()
    
    lazy var doubleTap = UIShortTapGestureRecognizer(target: self, action: #selector(self.handleDoubleTap(sender:)))
    lazy var pan = UIPanTouchDownGestureRecognizer(target: self, action: #selector(handlePan(sender:)))
    lazy var singleTap = UITapGestureRecognizer(target: self, action: #selector(handleSingleTap(sender:)))
    
    let barView = UIView(frame: .zero)
    let textView = UILabel(frame: .zero)
    let rightButton = UIView(frame: .zero)
    
    var lastSelected: Int = 4
    var selectedDay: Int = 4 {
        didSet {
            NSLayoutConstraint.deactivate([horizontalRowsWidths[lastSelected].featuredWidth, horizontalRowsWidths[self.selectedDay].standardWidth])
            NSLayoutConstraint.activate([horizontalRowsWidths[self.selectedDay].featuredWidth, horizontalRowsWidths[lastSelected].standardWidth])
            self.horizontalRows[self.selectedDay].backgroundColor = .systemGray4
            self.horizontalRows[lastSelected].backgroundColor = .systemGray6
            self.horizontalRows[self.selectedDay].layer.cornerRadius = 5
            self.horizontalRows[lastSelected].layer.cornerRadius = 0
            UIView.animate(withDuration: 0.25) {
                self.view.layoutIfNeeded()
            }
            lastSelected = self.selectedDay
        }
    }
    
    var weeks: [ScheduleWeek]? = []
    var days: [ScheduleDay]? = []
    var selectedWeek: Int = 0 {
        didSet {
            print("selectedWeek didSet")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let dates = CoreDataStack().avaibleDates()
//        var date: Date
//        if dates.count > 0 {
//            print(dates.count)
//            date = dates[0]
//            CoreDataStack().weekForDate(date: date)
//        }
        self.weeks = CoreDataStack().fetchWeeks()
        self.days = weeks!.last?.day?.allObjects as? [ScheduleDay]
        self.days!.sort(by: { $0.dayNumber < $1.dayNumber })
//        print(days)
//        for day in days! {
//            print(day.dayNumber)
//        }
        
        setupBarView()
        setupViews()
    }
    
    
    
    var beganPanLocation: Int?
    var endedPanLocation: Int?
    
    @objc func handlePan(sender: UIPanTouchDownGestureRecognizer) {
        if !(self.rightButton.frame.contains(sender.location(in: self.view))) {
            let location = sender.location(in: self.view).x
            var selectedIndex = Int()
            for i in 0...4 {
                if self.horizontalRows[i].frame.minX < location && location < self.horizontalRows[i].frame.maxX {
                    selectedIndex = i
                }
            }
            if location < self.horizontalRows[selectedDay].frame.minX || location > self.horizontalRows[selectedDay].frame.maxX {
                self.selectedDay = selectedIndex
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
        }
    }
    
    @objc func handleDoubleTap(sender: UITapGestureRecognizer) {
        self.horizontalRows[self.selectedDay].scrollingEnabled = false
        self.horizontalRows[self.selectedDay].selected = 0
//        self.view.removeGestureRecognizer(doubleTap)
        self.view.removeGestureRecognizer(singleTap)
        self.view.addGestureRecognizer(pan)
        featuredWidth()
    }
    
    @objc func handleSingleTap(sender: UITapGestureRecognizer) {
        let cellHeight = self.horizontalRows[self.selectedDay].frame.height / 10
        let location = sender.location(in: self.horizontalRows[selectedDay]).y
        for i in 0...9 {
            if self.horizontalRows[selectedDay].cells[i].frame.minY < location && self.horizontalRows[selectedDay].cells[i].frame.maxY > location {
                var newOffset = cellHeight * CGFloat(i)
                if i != 9 {
                    newOffset += 25
                }
                self.horizontalRows[self.selectedDay].setContentOffset(CGPoint(x: 0, y: newOffset), animated: true)
                self.horizontalRows[self.selectedDay].selected = i
            }
        }
    }
    
    func setupBarView() {
        barView.backgroundColor = .systemGray6
        barView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(barView)
        NSLayoutConstraint.activate([
            barView.widthAnchor.constraint(equalTo: view.widthAnchor),
            barView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            barView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 1/12)
        ])
//        textView.text = "2020-02-10 - 2020-02-16"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd"
        textView.text = dateFormatter.string(from: weeks![selectedWeek].startDate!)
//        textView.text = weeks![selectedWeek].startDate.text
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
//        rightButton.backgroundColor = .systemTeal
        rightButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            rightButton.leftAnchor.constraint(equalTo: textView.rightAnchor),
            rightButton.rightAnchor.constraint(equalTo: barView.rightAnchor),
            rightButton.heightAnchor.constraint(equalTo: barView.heightAnchor)
        ])
    }
    
    func setupViews() {
        for i in 0...4 {
            
            let dayData = self.days![i]
            var lessons = dayData.lesson?.allObjects as? [ScheduleLesson]
            lessons!.sort(by: { $0.lessonNumber < $1.lessonNumber })
            
            let horizontalRow = ScheduleDayView(frame: .zero, lessons: lessons)
            
            horizontalRow.setupTopAnchorConstraintsForWeekView = horizontalRow.setup.topAnchor.constraint(equalTo: horizontalRow.topAnchor)
            horizontalRow.setupTopAnchorConstraintsForWeekView.isActive = true
            var height = self.view.frame.height - UIApplication.shared.statusBarFrame.height - (self.tabBarController?.tabBar.frame.height)!
            height = height * 11/12
            horizontalRow.setupTopAnchorConstraintsForDayView = horizontalRow.setup.topAnchor.constraint(equalTo: horizontalRow.topAnchor, constant: height * 2)
 
            horizontalRows.append(horizontalRow)
            view.addSubview(horizontalRow)
            horizontalRow.translatesAutoresizingMaskIntoConstraints = false
            horizontalRow.topAnchor.constraint(equalTo: barView.bottomAnchor).isActive = true
            horizontalRow.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
            if i == 0 {
                horizontalRow.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
            } else {
                horizontalRow.leftAnchor.constraint(equalTo: horizontalRows[i - 1].rightAnchor).isActive = true
            }
            let widths = HorizontalRowWidth(standardWidth: horizontalRow.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 2/11), featuredWidth: horizontalRow.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 3/11), superWidth: horizontalRow.widthAnchor.constraint(equalTo: view.widthAnchor), zeroWidth: horizontalRow.widthAnchor.constraint(equalToConstant: 0.0))
            
            if selectedDay == i {
                widths.featuredWidth.isActive = true
                horizontalRow.backgroundColor = .systemGray4
                horizontalRow.layer.cornerRadius = 5
            } else {
                widths.standardWidth.isActive = true
            }
            horizontalRowsWidths.append(widths)
        }
        view.backgroundColor = .systemGray6
        view.addGestureRecognizer(pan)
    }
    
    func featuredWidth() {
        for i in 0...4 {
            if selectedDay == i {
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
            }
        }
        self.horizontalRows[self.selectedDay].setupTopAnchorConstraintsForDayView.isActive = false
        self.horizontalRows[self.selectedDay].setupTopAnchorConstraintsForWeekView.isActive = true
        UIView.animate(withDuration: 0.25, animations: {
            self.view.layoutIfNeeded()
        }, completion: { _ in
            
        })
    }
    
    func superWidth() {
        self.horizontalRows[self.selectedDay].scrollingEnabled = true
        for i in 0...4 {
            if selectedDay == i {
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
            
            self.horizontalRows[self.selectedDay].setupTopAnchorConstraintsForWeekView.isActive = false
            self.horizontalRows[self.selectedDay].setupTopAnchorConstraintsForDayView.isActive = true
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
            
            let image = UIImage(systemName: "chevron.right", withConfiguration: UIImage.SymbolConfiguration(pointSize: 16, weight: .bold))
            let imageView = UIImageView(image: image!)
            imageView.image?.withRenderingMode(.alwaysTemplate)
            imageView.tintColor = .systemPurple
            imageView.frame = CGRect(x: width/5, y: height/5, width: safeWidth, height: safeHeight)
            rightButton.addSubview(imageView)
            
            
//            print(self.horizontalRows[0].frame)
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
