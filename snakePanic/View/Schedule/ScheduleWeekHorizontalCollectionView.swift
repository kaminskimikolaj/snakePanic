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
        self.collectionView!.register(ScheduleWeekVerticalCell.self, forCellWithReuseIdentifier: ScheduleWeekVerticalCell.identifier)
    }
}

extension ScheduleWeekHorizontalCollectionView {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: ScheduleWeekVerticalCell.identifier, for: indexPath)

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
        size.width = (size.width / 5) - 4.0
        return size
    }
}
