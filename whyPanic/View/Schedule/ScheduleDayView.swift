import UIKit

class ScheduleDayView: UIScrollView {
    
    var cells = [UIView]()
    var setup = UIView(frame: .zero)
    var setupTopAnchorConstraintsForWeekView = NSLayoutConstraint()
    var setupTopAnchorConstraintsForDayView = NSLayoutConstraint()
    var cellsConstraints = [CellHeight]()
    var scrollingEnabled = true
    
    var lessons: [ScheduleLesson]?
    
    var lastSelected = 0
    var selected: Int = 0 {
        didSet {
//            NSLog("selected: \(self.selected)")
            cellsConstraints[self.lastSelected].dayFeaturedHeight.isActive = false
            cellsConstraints[self.lastSelected].dayStandardHeight.isActive = true

            cellsConstraints[self.selected].dayStandardHeight.isActive = false
            cellsConstraints[self.selected].dayFeaturedHeight.isActive = true
            
            lastSelected = self.selected
            
            UIView.animate(withDuration: 0.25, animations: {
                self.layoutIfNeeded()
            })
        }
    }

    struct CellHeight {
        let weekHeight: NSLayoutConstraint
        let dayStandardHeight: NSLayoutConstraint
        let dayFeaturedHeight: NSLayoutConstraint
    }
    
    convenience init(frame: CGRect, lessons: [ScheduleLesson]?) {
        self.init(frame: frame)
        self.lessons = lessons
        setupView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func action(sender: UIButton!) {
//        print("action")
    }
    
    private func setupView() {
        
        showsVerticalScrollIndicator = false
        backgroundColor = .systemGray6
        bounces = false

        addSubview(setup)
        setup.translatesAutoresizingMaskIntoConstraints = false
        setup.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        setup.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        setup.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        
        for i in 0...9 {
            let cell = UIView(frame: .zero)
            addSubview(cell)
            cell.translatesAutoresizingMaskIntoConstraints = false
            cell.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
            if i == 0 {
                cell.topAnchor.constraint(equalTo: topAnchor).isActive = true
            } else {
                cell.topAnchor.constraint(equalTo: cells[i - 1].bottomAnchor).isActive = true
            }
            let heights = CellHeight(
                weekHeight: cell.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1/10),
                dayStandardHeight: cell.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 2/11),
                dayFeaturedHeight: cell.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 4/11))
            heights.weekHeight.isActive = true
            
            self.cellsConstraints.append(heights)
            cells.append(cell)

            let contentCell = UILabel(frame: .zero)
            contentCell.backgroundColor = .systemGray2
            contentCell.layer.cornerRadius = 5.0
            contentCell.clipsToBounds = true
            contentCell.contentMode = .scaleToFill
            contentCell.accessibilityIdentifier = "contentCell"
            cell.addSubview(contentCell)
            contentCell.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                contentCell.heightAnchor.constraint(equalTo: cell.heightAnchor, multiplier: 9/10),
                contentCell.widthAnchor.constraint(equalTo: cell.widthAnchor, multiplier: 9/10),
                contentCell.centerXAnchor.constraint(equalTo: cell.centerXAnchor),
                contentCell.centerYAnchor.constraint(equalTo: cell.centerYAnchor)
            ])
            if i < lessons!.count {
                contentCell.font = contentCell.font.withSize(2)
                let number = calculateNumberOfLines(string: lessons![i].lessonName!).count
                contentCell.numberOfLines = number
                contentCell.text = lessons![i].lessonName!
                contentCell.textAlignment = .center
            }
        }
    }
    
//    func scrollToSelected() {
//        print(self.frame.height)
//        var offset: CGFloat = 0
//        for i in 0...self.selected {
//            offset += self.cells[i].frame.height
//        }
//        print(offset)
//        offset -= self.frame.height
//        print(offset)
//        self.setContentOffset(CGPoint(x: 0, y: offset), animated: false)
//        print(contentOffset)
//        let cellHeight = self.frame.height / 10
//        self.setContentOffset(CGPoint(x: 0, y: cellHeight * CGFloat(self.selected)), animated: true)
//    }
    
    private func calculateNumberOfLines(string: String) -> [String] {
        var output = [String]()
        var buffer = ""
        for char in string {
            if char == " " {
                output.append(buffer)
                buffer = ""
            } else {
                buffer += char.description
            }
        }
        output.append(buffer)
        return output
    }
    
    func calculateFontSize() -> CGFloat {
        var list = [CGFloat]()
        var min = CGFloat(20)
        var fontSize = CGFloat()
        for lesson in self.lessons! {
            let formatted = calculateNumberOfLines(string: lesson.lessonName!)
            for line in formatted {
                fontSize = CGFloat(1)
                var loop = true
                while loop {
                    let font = UIFont.systemFont(ofSize: fontSize)
                    let currentSize = (line as NSString).size(withAttributes: [NSAttributedString.Key.font: font])
                    if currentSize.width < self.cells[0].frame.width {
                        fontSize += 1
                    } else {
                        loop = false
                        fontSize -= 1
                        list.append(fontSize)
                        if min > fontSize {
                            min = fontSize
                        }
//                        if ScheduleWeekView.fontSize > fontSize {
//                            ScheduleWeekView.fontSize = fontSize
//                        }
                    }
                }
            }
        }
//        print(list, min)
//        if ScheduleWeekView.fontSize > min {
//            ScheduleWeekView.fontSize =  min
//        }
//        ScheduleWeekView.dayCounter += 1
//        print(ScheduleWeekView.dayCounter)
        return min
    }
}

extension Array {
    subscript (safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
}

//THIS PART BELOW WAS INTENDED FEAUTERE BUT IT BREAKS SCROLL VIEW

//extension ScheduleDayView: UIScrollViewDelegate {
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        var pos = scrollView.contentOffset.y
//        NSLog("pos: \(pos)")
//        let cellHeight = self.frame.height / 10
//        var indexCounter = 0
//        while true {
//            if pos >= cellHeight && indexCounter < 9 {
//                pos -= cellHeight
//                indexCounter += 1
//            } else {
//                if indexCounter != self.selected && canIScroll {
//                    self.selected = indexCounter
//                }
//                break
//            }
//        }
//    }
//}
