//
//  TopBarTestViewController.swift
//  snakePanic
//
//  Created by Mikołaj Kamiński on 08/02/2020.
//  Copyright © 2020 Mikołaj Kamiński. All rights reserved.
//

import UIKit

class TopBarTestViewController: UIViewController {

    let barView = UIView(frame: .zero)
    let textView = UILabel(frame: .zero)
    let rightButton = UIView(frame: .zero)
    
    func scrapLessonScheduleAndSave() {
        let semaphore = DispatchSemaphore(value: 0)
        DispatchQueue.global(qos: .background).async {
            do { try HttpsScrapper().login(user: "S45_AR4Q5848168", pass: "c9VYgL4R") { result in
                print(result)
                semaphore.signal()
            }}
            catch let error { print(error) }
            semaphore.wait()

            do { try HttpsScrapper().scrapLessonsSchedule() { result in
                switch result {
                case .success(let data):
                    print(data)
                    let stack = CoreDataStack.sharedInstance
                    stack.saveContext()
                case .failure(let error):
                    print("Error: \(error)")
                }
                semaphore.signal()
            }}
            catch let error { print(error) }
        }
    }

    override func viewDidLoad() {
        
        scrapLessonScheduleAndSave()
//        do { try print(CoreDataStack().lessonsForDay(dayNumber: 2)[0].lessonName)
//        } catch { print("lkjsdlfja") }
    
        
        view.backgroundColor = .systemGray
        barView.backgroundColor = .systemGray6
        barView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(barView)
        NSLayoutConstraint.activate([
            barView.widthAnchor.constraint(equalTo: view.widthAnchor),
            barView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            barView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 1/12)
        ])

//        textView.text = "test test test test test test test test test test test"
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
        rightButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            rightButton.leftAnchor.constraint(equalTo: textView.rightAnchor),
            rightButton.rightAnchor.constraint(equalTo: barView.rightAnchor),
            rightButton.heightAnchor.constraint(equalTo: barView.heightAnchor)
        ])
    }

    override func viewDidLayoutSubviews() {

        let height = view.safeAreaLayoutGuide.layoutFrame.height / 12
        let width = view.frame.width / 10

        let safeHeight = height * 3/5
        let safeWidth = width * 3/5

        let image = UIImage(named: "button37d2")
        let imageView = UIImageView(image: image!)
        imageView.frame = CGRect(x: width/5, y: height/5, width: safeWidth, height: safeHeight)
        rightButton.addSubview(imageView)
    }

}
