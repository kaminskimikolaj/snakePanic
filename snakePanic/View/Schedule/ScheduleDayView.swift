import UIKit

class ScheduleDayView: UIScrollView {
    
    var cells = [UIView]()
    var setup = UIView(frame: .zero)
    var setupTopAnchorConstraintsForWeekView = NSLayoutConstraint()
    var setupTopAnchorConstraintsForDayView = NSLayoutConstraint()
    var cellsConstraints = [CellHeight]()
    var canIScroll = true
    
    var lastSelected = 0
    var selected: Int = 0 {
        didSet {
            NSLog("selected: \(self.selected)")
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func action(sender: UIButton!) {
        print("action")
    }
    
    private func setupView() {
        showsVerticalScrollIndicator = false
//        delegate = self
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

//            let contentCell = UIButton(frame: .zero)
            let contentCell = UIView(frame: .zero)
//            contentCell.addTarget(self, action: #selector(action(sender:)), for: .touchDown)
            contentCell.backgroundColor = .systemGray2
//            if i % 2 == 0 {
//                contentCell.backgroundColor = .systemTeal
//            } else {
//                contentCell.backgroundColor = .systemGreen
//            }
            contentCell.layer.cornerRadius = 5.0
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
