import UIKit

class TestViewController2: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let subview = UIView(frame: view.safeAreaLayoutGuide.layoutFrame)
        subview.backgroundColor = .systemPink
        view.addSubview(subview)
        
        let scroll = UIScrollView(frame: .zero)
        view.addSubview(scroll)
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scroll.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor).isActive = true
        scroll.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        
        scroll.contentSize = CGSize(width: view.frame.width * 2 - 1, height: scroll.frame.height)
//        scroll.backgroundColor = .systemTeal
        
        scroll.bounces = false
        scroll.delegate = self
        scroll.showsHorizontalScrollIndicator = false
        
    }
    
    var selected: Int = 0 {
        didSet {
            print("selected \(self.selected)")
        }
    }
}

extension TestViewController2: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pos = scrollView.contentOffset.x + 1
        if pos / 64 - CGFloat(selected) > 1 {
            selected += 1
        }
        if CGFloat(selected) - pos / 64 > 0 {
            selected -= 1
        }
    }
}
