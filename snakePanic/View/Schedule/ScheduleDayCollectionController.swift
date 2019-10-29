//
//  TestCollectionView.swift
//  sip2po
//
//  Created by Mikołaj Kamiński on 15/10/2019.
//  Copyright © 2019 Mikołaj Kamiński. All rights reserved.
//

import UIKit

class ScheduleDayCollectionController: UIViewController {
    
    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    var data: [ScheduleLesson] = []
    var collectionLength = Int()
    var switched = false
    
    enum CoreDataError: Error {
        case fetchingError
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tabBarController?.viewControllers?[0].tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "Schedule"), tag: 0)
        tabBarController?.selectedIndex = 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        if let currentDispatch = OperationQueue.current?.underlyingQueue {
//            print(currentDispatch)
//        }
        do {
            try self.data = CoreDataStack.sharedInstance.lessonsForDayPredicate(dayNumber: 4)
        } catch let error {
            print(error)
        }
        setupCollectionView()
        if self.data.count == 0 {
            collectionLength = 0
        } else {
            collectionLength = self.data.count + 2
        }
    }
    
    func setupCollectionView() {
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.minimumLineSpacing = 10
        self.collectionView.collectionViewLayout = collectionViewFlowLayout
        view.backgroundColor = .systemGroupedBackground
        view.addSubview(collectionView)
//        collectionView.setCollectionViewLayout(CollectionFlowLayout(), animated: true)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -10.0).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 10.0).isActive = true
        collectionView.backgroundColor = .systemGroupedBackground
        collectionView.showsVerticalScrollIndicator = false
        collectionView.bounces = false
        collectionView.allowsSelection = true
        
        collectionView.register(TestContentCell .self, forCellWithReuseIdentifier: TestContentCell.identifier2)
        collectionView.register(StartCell.self, forCellWithReuseIdentifier: StartCell.identifier)
        collectionView.register(EndCell.self, forCellWithReuseIdentifier: EndCell.identifier)

        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    
    var selected = [IndexPath]()
    
    var selectedIndexPath: IndexPath? {
        didSet {
            var indexPaths: [IndexPath] = []
            if let selectedIndexPath = selectedIndexPath {
                indexPaths.append(selectedIndexPath)
            }
            if let oldValue = oldValue {
                indexPaths.append(oldValue)
            }
            UIView.setAnimationsEnabled(false)
            self.collectionView.performBatchUpdates({
                self.collectionView.reloadItems(at: indexPaths)
            }) { _ in
                if let selectedIndexPath = self.selectedIndexPath {
                    self.collectionView.scrollToItem(at: selectedIndexPath, at: .centeredVertically, animated: true)
                    UIView.setAnimationsEnabled(true)
                }
            }
        }
    }
}

extension ScheduleDayCollectionController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionLength
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StartCell.identifier, for: indexPath) as! StartCell
            cell.label.text = data.first?.start
            return cell
        }
        
        if indexPath.row == collectionLength - 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EndCell.identifier, for: indexPath) as! EndCell
            cell.label.text = data.last?.end
            return cell
        }
//        var movedIndexPath = indexPath
//        movedIndexPath.row += 1
//        let lesson = fetchedResultsController.object(at: movedIndexPath)
        let lesson = data[indexPath.row - 1]
        print(lesson)
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TestContentCell.identifier2, for: indexPath) as! TestContentCell
        cell.label.text = lesson.lessonName!
        return cell
    }
}

extension ScheduleDayCollectionController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            
        var size = collectionView.frame.size
        size.height = 100.0
        if indexPath.row == 0 || indexPath.row == collectionLength - 1 {
            size.height = 80.0
        }
        return size
//        var size = collectionView.frame.size
//        size.height = 100.0
//        if indexPath == selectedIndexPath {
//            size.height = 150.0
//        } else if indexPath.row == 0 || indexPath.row == collectionLength - 1 {
//            size.height = 80.0
//        }
//        return size
    }
}
    

extension ScheduleDayCollectionController: UICollectionViewDelegate {
    
//    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
//
//        if selectedIndexPath == indexPath {
//            selectedIndexPath = nil
//        } else {
//            selectedIndexPath = indexPath
//        }
//
//        return false
//     }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            navigationController?.pushViewController(PurpleViewController(), animated: true)
//            tabBarController?.viewControllers?[0].tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "List"), tag: 0)
//            self.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "List"), tag: 0)
        }
    }
}

class TestContentCell: UICollectionViewCell {
    
    static let identifier2 = "ContentCell"
//    var data: ScheduleLesson
    let label = UILabel(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemGray5
        layer.cornerRadius = 20.0
        
        label.textColor = .label
        label.textAlignment = .center
        label.font = label.font.withSize(25.0)
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: topAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        label.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class EndCell: UICollectionViewCell {
    
    static let identifier = "StartCell"
    var first = true
    var label = UILabel(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        contentView.addSubview(label)
        label.textColor = .systemPurple
        label.textAlignment = .center
        label.font = label.font.withSize(40.0)

        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: -10.0).isActive = true
        label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        label.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class StartCell: UICollectionViewCell {
    
    static let identifier = "EndCell"
    var first = true
    var label = UILabel(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        contentView.addSubview(label)
        label.textColor = .systemPurple
        label.textAlignment = .center
        label.font = label.font.withSize(40.0)

        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10.0).isActive = true
        label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        label.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
