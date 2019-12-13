import UIKit

class ScheduleDayView: UIScrollView {
    
    var cells = [UIView]()
    var setup = UIView(frame: .zero)
    var setupTopAnchorConstraintsForWeekView = NSLayoutConstraint()
    var setupTopAnchorConstraintsForDayView = NSLayoutConstraint()
    var cellsConstraints = [CellHeight]()
    
    var lastSelected = 0
    var selected: Int = 0 {
        didSet {
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
    
    @objc func handleTap(sender: UITapGestureRecognizer) {
        let location = sender.location(in: self).y
        for i in 0...9 {
            if cells[i].frame.minY < location && cells[i].frame.maxX > location && i != self.selected {
                selected = i
            }
        }
    }
    
    private func setupView() {
        showsVerticalScrollIndicator = false
        delegate = self
        backgroundColor = .systemGray6
        bounces = false
        
        let touchUpInside = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        addGestureRecognizer(touchUpInside)
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

            let contentCell = UIView(frame: .zero)
            if i % 2 == 0 {
                contentCell.backgroundColor = .systemTeal
            } else {
                contentCell.backgroundColor = .systemGreen
            }
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
}

extension ScheduleDayView: UIScrollViewDelegate {
    

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var pos = scrollView.contentOffset.y
        let cellHeight = self.frame.height / 10
        var keepGoing = true
        var indexCounter = 0
        while true {
            if pos >= cellHeight && indexCounter < 9 {
                pos -= cellHeight
                indexCounter += 1
            } else {
                if indexCounter != self.selected {
                    self.selected = indexCounter
                }
                break
            }
        }
    }
}
