import UIKit

class ScheduleDayView: UIScrollView {
    
    enum ScheduleDayViewState {
        case featuredView
        case standardView
        case zeroView
        case superView
    }
    
    var fontSizes: ScheduleDayViewFontSize?
    
    var state: ScheduleDayViewState? {
        didSet {
            setFontSizes()
        }
    }
    private func setFontSizes() {
        if self.fontSizes != nil {
            switch (self.state) {
                case .featuredView: setFontSizeTo(fontSize: fontSizes!.featuredFontSize)
                case .standardView: setFontSizeTo(fontSize: fontSizes!.standardFontSize)
                case .superView: setFontSizeTo(fontSize: fontSizes!.superFontSize)
                case .zeroView: setFontSizeTo(fontSize: fontSizes!.zeroFontSize)
                default: print("ScheduleDayView.state not set yet")
            }
        }
    }
    
    private func setFontSizeTo(fontSize: CGFloat) {
        for cell in cells {
            for subview in cell.subviews {
                let label = subview as! UILabel
                label.font = label.font.withSize(fontSize)
            }
        }
    }
    
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
            if i < lessons!.count {
//                contentCell.font = contentCell.font.withSize(2)
                let number = calculateNumberOfLines(string: lessons![i].lessonName!).count
                contentCell.numberOfLines = number
                contentCell.text = lessons![i].lessonName!
                contentCell.textAlignment = .center
            }
        }
    }
    
    func calculateNumberOfLines(string: String) -> [String] {
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

}

extension ScheduleDayView: FontSizeDelegate {
    func writeFontSizes(sizes: ScheduleDayViewFontSize) {
        self.fontSizes = sizes
        setFontSizes()
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
