//
//  BackgroundViewController.swift
//  sip2po
//
//  Created by Mikołaj Kamiński on 26/10/2019.
//  Copyright © 2019 Mikołaj Kamiński. All rights reserved.
//

import UIKit

class PinkViewController: UIViewController {
    override func viewDidLoad() {
        
        let path = UIBezierPath()
        let cellWidth = view.frame.width
        let cellHeight = CGFloat(100.0)
        let margin = CGFloat(15.0)
        let cornerSize = margin * 2
        let start = CGPoint(x: margin, y: cornerSize)
        
        path.move(to: start)
        path.addLine(to: CGPoint(x: cornerSize, y: margin))
        path.addLine(to: CGPoint(x: cellWidth - margin, y: margin))
        path.addLine(to: CGPoint(x: cellWidth - margin, y: cellHeight - cornerSize))
        path.addLine(to: CGPoint(x: cellWidth - cornerSize, y: cellHeight - margin))
        path.addLine(to: CGPoint(x: margin, y: cellHeight - margin))
        path.addLine(to: start)
        
        let layer = CAShapeLayer()
        layer.path = path.cgPath
        layer.fillColor = UIColor.systemGray2.cgColor
        
        let shadowPath = UIBezierPath()
        shadowPath.move(to: CGPoint(x: margin, y: cellHeight - margin))
        shadowPath.addLine(to: CGPoint(x: margin, y: cellHeight - margin + 10.0))
        shadowPath.addLine(to: CGPoint(x: cellWidth - cornerSize, y: cellHeight - margin + 10.0))
        shadowPath.addLine(to: CGPoint(x: cellWidth - margin, y: cellHeight - cornerSize + 10.0))
        shadowPath.addLine(to: CGPoint(x: cellWidth - margin, y: cellHeight - cornerSize))
        shadowPath.addLine(to: CGPoint(x: cellWidth - cornerSize, y: cellHeight - margin))
        
        let shadowLayer = CAShapeLayer()
        shadowLayer.path = shadowPath.cgPath
        shadowLayer.fillColor = UIColor.systemGray5.cgColor
        
        let subview = UIView(frame: .zero)
//        subview.backgroundColor = .systemTeal
        
        view.addSubview(subview)
        subview.translatesAutoresizingMaskIntoConstraints = false
        subview.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        subview.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        subview.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        subview.heightAnchor.constraint(equalToConstant: 130.0).isActive = true
        subview.layer.addSublayer(layer)
        subview.layer.addSublayer(shadowLayer)
        
        
        
        let text = UILabel(frame: .zero)
        text.text = "Matematyka"
        text.textAlignment = .center
        
//        for family in UIFont.familyNames.sorted() {
//            let names = UIFont.fontNames(forFamilyName: family)
//            print("Family: \(family) Font names: \(names)")
//        }
        
        guard let customFont = UIFont(name: "AndaleMono", size: UIFont.labelFontSize) else { fatalError("Failed importing font") }
        text.font = UIFontMetrics.default.scaledFont(for: customFont)
//        text.backgroundColor = UIColor.systemPurple.withAlphaComponent(0.5)
        subview.addSubview(text)
        text.translatesAutoresizingMaskIntoConstraints = false
        text.topAnchor.constraint(equalTo: subview.topAnchor, constant: 30.0).isActive = true
        text.bottomAnchor.constraint(equalTo: subview.bottomAnchor, constant: -60.0).isActive = true
        text.rightAnchor.constraint(equalTo: subview.rightAnchor, constant: -30.0).isActive = true
        text.leftAnchor.constraint(equalTo: subview.leftAnchor, constant: 30.0).isActive = true
        text.font = text.font.withSize(100.0)
        text.adjustsFontSizeToFitWidth = true
        text.numberOfLines = 0
    }
}
