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
        calculateFontSize()
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
            cell.addSubview(contentCell)
            contentCell.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                contentCell.heightAnchor.constraint(equalTo: cell.heightAnchor, multiplier: 9/10),
                contentCell.widthAnchor.constraint(equalTo: cell.widthAnchor, multiplier: 9/10),
                contentCell.centerXAnchor.constraint(equalTo: cell.centerXAnchor),
                contentCell.centerYAnchor.constraint(equalTo: cell.centerYAnchor)
            ])
//            contentCell.text = "testtest test"
//            contentCell.adjustsFontSizeToFitWidth = true
//            contentCell.numberOfLines =
//            contentCell.textAlignment = .center
            
//            let textOffset = UIView(frame: .zero)
//            contentCell.addSubview(textOffset)
//            contentCell.translatesAutoresizingMaskIntoConstraints = false
//            NSLayoutConstraint.activate([
//                textOffset.heightAnchor.constraint(equalTo: contentCell.heightAnchor, multiplier: 9/10),
//                textOffset.widthAnchor.constraint(equalTo: contentCell.widthAnchor, multiplier: 9/10),
//                textOffset.centerXAnchor.constraint(equalTo: contentCell.centerXAnchor),
//                textOffset.centerYAnchor.constraint(equalTo: contentCell.centerYAnchor)
//            ])
//            var lines = [UIView]()
            if i < lessons!.count {
                contentCell.font = contentCell.font.withSize(7)
                let number = calculateNumberOfLines(string: lessons![i].lessonName!).count
//                print(number)
                contentCell.numberOfLines = number
//                contentCell.lineBreakMode = .byWordWrapping
                contentCell.text = lessons![i].lessonName!
                contentCell.textAlignment = .center
                
//                let contentLabel = UILabel(frame: .zero)
//                contentCell.addSubview(contentLabel)
//                contentLabel.translatesAutoresizingMaskIntoConstraints = true
//                contentLabel.text = lessons![i].lessonName
////                contentLabel.adjustsFontSizeToFitWidth = true
//                contentLabel.lineBreakMode = .byWordWrapping
//                contentLabel.textAlignment = .center
//
//                NSLayoutConstraint.activate([
//                    contentLabel.heightAnchor.constraint(equalTo: contentCell.heightAnchor, multiplier: 9/10),
//                    contentLabel.widthAnchor.constraint(equalTo: contentCell.widthAnchor, multiplier: 9/10),
//                    contentLabel.centerXAnchor.constraint(equalTo: contentCell.centerXAnchor),
//                    contentLabel.centerYAnchor.constraint(equalTo: contentCell.centerYAnchor)
//                ])
//                calculateNumberOfLines(string: lessons![i].lessonName!)

//                let text = calculateNumberOfLines(string: lessons![i].lessonName!)
//                print(text)
//                for j in 0...(text.count - 1) {
//                    print("entered")
//                    let contentLabelLine = UILabel(frame: .zero)
//                    contentLabelLine.contentMode = .scaleAspectFill
//                    contentCell.addSubview(contentLabelLine)
//                    contentLabelLine.translatesAutoresizingMaskIntoConstraints = false
//                    contentLabelLine.widthAnchor.constraint(equalTo: contentCell.widthAnchor).isActive = true
//
//                    if j == 0 {
//                        contentLabelLine.topAnchor.constraint(equalTo: contentCell.topAnchor).isActive = true
//                    } else {
//                        contentLabelLine.topAnchor.constraint(equalTo: lines.last!.bottomAnchor).isActive = true
//                    }
//                    print(1.0 / Double(text.count))
//                    contentLabelLine.heightAnchor.constraint(equalTo: contentCell.heightAnchor, multiplier: CGFloat(1.0 / Double(text.count))).isActive = true
//                    lines.append(contentLabelLine)
//
//                    contentLabelLine.textAlignment = .center
//                    contentLabelLine.adjustsFontSizeToFitWidth = true
//                    contentLabelLine.text = text[j]
//                }
            } else {
//                contentCell.backgroundColor = .systemPink
//                let subview = UILabel(frame: .zero)
//                subview.text = "G"
//            if let font = UIFont(name: , size: 10)
//                let font = subview.font
//                let text = "test test"
//                subview.font = subview.font.withSize(15)
//                let fontAttyributes =
//                subview.text = text
//                print(subview.font)
//                let size = (text as NSString).size(withAttributes: [NSAttributedString.Key.font: subview.font])
//                subview.frame.size = size
//                subview.backgroundColor = .systemPink
//                contentCell.addSubview(subview)
            }
//            contentLabel.contentMode = .scaleAspectFill
//            contentCell.addSubview(contentLabel)
//            contentLabel.translatesAutoresizingMaskIntoConstraints = false
//            NSLayoutConstraint.activate([
//                contentLabel.heightAnchor.constraint(equalTo: contentCell.heightAnchor, multiplier: 9/10),
//                contentLabel.widthAnchor.constraint(equalTo: contentCell.widthAnchor, multiplier: 9/10),
//                contentLabel.centerXAnchor.constraint(equalTo: contentCell.centerXAnchor),
//                contentLabel.centerYAnchor.constraint(equalTo: contentCell.centerYAnchor)
//            ])
//            if i > 0 && i < 8 {
//                let index = i - 1
//                if lessons?[safe: index] != nil {
//                    if lessons![index].proxy {
//                        contentCell.backgroundColor = .systemPink
//                    }
//                    if lessons![index].released {
//                        contentCell.backgroundColor = .systemGreen
//                    }
//                }
//            }
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
    
    private func calculateFontSize() {
//        for lesson in self.lessons! {
//            print(lesson.lessonName)
//        }
//        print(self.cells[0].frame)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        var maxFontSize = Int()
        var maxSize = CGSize()
//        var isInitial = true
//        for lesson in self.lessons! {
//            let formatted = calculateNumberOfLines(string: lesson.lessonName!)
//            for line in formatted {
//
//                var stop = false
//                var localFontSize = 1
//                while stop {
//                    let font = UIFont.systemFont(ofSize: CGFloat(localFontSize))
////    //                print((line as NSString).size(withAttributes: [NSAttributedString.Key.font: font]).width, self.cells[0].frame.width)
//                    let currentSize = (line as NSString).size(withAttributes: [NSAttributedString.Key.font: font])
//                    if currentSize.width < self.cells[0].frame.width && currentSize.height * CGFloat(formatted.count) < self.cells[0].frame.height {
//                        if isInitial {
//                            localFontSize += 1
//                        } else if localFontSize < maxFontSize {
//                            localFontSize += 1
//                        }
//                    } else {
//                        maxFontSize = localFontSize
//                        maxSize = currentSize
//                        isInitial = false
//                        stop = true
//                    }
//                }
//            }
//        }
        var list = [CGFloat]()
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
                        list.append(fontSize)
                    }
                }
            }
        }
        print(list)
//        print(maxFontSize, maxSize, self.cells[0].frame.size)
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
