//
//  ScheduleWeekCollectionView.swift
//  sip2po
//
//  Created by Mikołaj Kamiński on 26/10/2019.
//  Copyright © 2019 Mikołaj Kamiński. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class ScheduleWeekHorizontalCollectionView: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView!.register(ScheduleWeekVerticalCell.self, forCellWithReuseIdentifier: ScheduleWeekVerticalCell.identifier)
            registerSwipeGestures()
            
    }
    var lastSelected: Int = 0
    var selected: Int = 0 {
        didSet {
            lastSelected = self.selected
            collectionView.reloadItems(at: [IndexPath(row: lastSelected, section: 0), IndexPath(row: self.selected, section: 0)])
            print("selected index \(selected)")
        }
    }
    
    func registerSwipeGestures() {
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)

        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
    }
    
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        if gesture.direction == .right {
            if selected > 0 {
                selected -= 1
            }
        }
        else if gesture.direction == .left {
            if selected < 4 {
                selected += 1
            }
        }
    }
}

extension ScheduleWeekHorizontalCollectionView {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        return collectionView.dequeueReusableCell(withReuseIdentifier: ScheduleWeekVerticalCell.identifier, for: indexPath)
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        cell.backgroundColor = .systemTeal
        return cell
//        switch indexPath.row {
//        case 0:
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
//            cell.backgroundColor = .systemGreen
//            return cell
//        case 1:
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
//            cell.backgroundColor = .systemOrange
//            let label = UILabel(frame: .zero)
//            label.numberOfLines = 2
//            label.allowsDefaultTighteningForTruncation = true
//            label.text = "Historia i społeczeństwo"
//            label.lineBreakMode = .byWordWrapping
//            label.textColor = .black
//            label.adjustsFontSizeToFitWidth = true
//            label.textAlignment = .center
//            cell.addSubview(label)
//            label.translatesAutoresizingMaskIntoConstraints = false
//            label.topAnchor.constraint(equalTo: cell.topAnchor).isActive = true
//            label.bottomAnchor.constraint(equalTo: cell.bottomAnchor).isActive = true
//            label.widthAnchor.constraint(equalTo: cell.widthAnchor).isActive = true
//
//            return cell
//        case 2:
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
//            cell.backgroundColor = .systemTeal
//            return cell
//        case 3:
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
//            cell.backgroundColor = .systemPink
//            return cell
//        case 4:
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
//            cell.backgroundColor = .systemYellow
//            return cell
//        default:
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
//            cell.backgroundColor = .white
//            return cell
//        }
    }
}

extension ScheduleWeekHorizontalCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var size = view.safeAreaLayoutGuide.layoutFrame.size
//        print(size)
        size.width = size.width / 5
//        if indexPath.row == selected {
//            size.width = size.width * 2
//        }
        size.width -= 4.0
//        print(size.width)
        return size
    }
}
