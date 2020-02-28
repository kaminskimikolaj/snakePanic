import UIKit

class YellowViewController: UIViewController {

    let container = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 1000))
    var lastTranslation: CGFloat = 0
    var lastTranslation2: CGFloat = 0
    var height: CGFloat = 0
    var lastState = UIPanGestureRecognizer.State.began
    var absΔchanged: Int = 0
    
    @objc func action(sender: UIPanGestureRecognizer) {

//        if sender.state != lastState {
//            print("last state: \(lastState.rawValue), new state: \(sender.state.rawValue)")
//            lastState = sender.state
//        }
//        print("last state: \(lastState.rawValue), new state: \(sender.state.rawValue)")
        
        let translation = sender.translation(in: container).y
        if sender.state == .ended && lastState == .changed {
            print("keep scrolling with speed: \(absΔchanged)")
        }
        if sender.state == .changed {
            absΔchanged = abs(Int(translation - lastTranslation2))
        }
        print(translation, lastTranslation2, sender.state.rawValue)
        
        lastState = sender.state
        lastTranslation2 = translation

        if sender.state == .began { lastTranslation = 0 }
        if container.frame.origin.y + (translation - lastTranslation) > 0 {
            container.frame.origin.y = 0
//            print(container.frame.origin.y)
        } else if 1000 + container.frame.origin.y + (translation - lastTranslation) < height {
//            print("now")
            container.frame.origin.y = -(1000 - height)
        } else {
            container.frame.origin.y += (translation - lastTranslation)
            lastTranslation = translation
//            print(container.frame.origin.y)
        }
        
//        if !(container.frame.origin.y + (translation - lastTranslation) > 0) && !(1000 + container.frame.origin.y + (translation - lastTranslation) < height) {
//            container.frame.origin.y += (translation - lastTranslation)
//            lastTranslation = translation
//            print(container.frame.origin.y)
//        }
    }
    
    @objc func handleDoubleTap(sender: UIShortTapGestureRecognizer) {
        print("recognized double tap")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        height = self.view.frame.height - (self.tabBarController?.tabBar.frame.height)!
//        print(view.frame.height)
        print(height)
        view.backgroundColor = .systemBlue
//        container.backgroundColor = .systemBlue
        view.addSubview(container)
        
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(action(sender:)))
        container.addGestureRecognizer(panGesture)
//
//        var doubleTap = UIShortTapGestureRecognizer(target: self, action: #selector(self.handleDoubleTap(sender:)))
//        doubleTap.numberOfTapsRequired = 2
//        container.addGestureRecognizer(doubleTap)
        
//        let cellSelect = UITapGestureRecognizer(target: self, action: #selector(<#T##@objc method#>))

        
        
        var subviews = [UIView]()
        
        for i in 0...9 {
            let subview = UIView(frame: .zero)
            if i % 2 == 0 {
                subview.backgroundColor = .systemPink
            } else {
                subview.backgroundColor = .systemOrange
            }
            subview.translatesAutoresizingMaskIntoConstraints = false
            container.addSubview(subview)
            subviews.append(subview)
            
            if i == 0 {
                subview.topAnchor.constraint(equalTo: container.topAnchor).isActive = true
            } else {
//                print(subviews)
                subview.topAnchor.constraint(equalTo: subviews[i - 1].bottomAnchor).isActive = true
            }
            subview.widthAnchor.constraint(equalTo: container.widthAnchor).isActive = true
            subview.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: 1/10).isActive = true
        }
    }
}
