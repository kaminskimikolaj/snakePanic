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
        let cellHeight = CGFloat(200.0)
        let margin = cellWidth / 15
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
        subview.heightAnchor.constraint(equalToConstant: 230.0).isActive = true
        subview.layer.addSublayer(layer)
        subview.layer.addSublayer(shadowLayer)
    }
}
