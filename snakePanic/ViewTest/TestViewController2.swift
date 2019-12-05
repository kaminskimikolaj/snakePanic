import UIKit

class TestViewController2: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupScroll()
    }
    
    func setupView() {
        let background = UIView(frame: view.safeAreaLayoutGuide.layoutFrame)
        background.backgroundColor = .systemGreen
        view.addSubview(background)
    }
    
    func setupScroll() {
        let scroll = UIScrollView(frame: .zero)
        view.addSubview(scroll)
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scroll.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor).isActive = true
        scroll.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scroll.contentSize = CGSize(width: view.frame.width * 2 - 1, height: scroll.frame.height)
        scroll.bounces = false
        scroll.delegate = self
        scroll.showsHorizontalScrollIndicator = true
        
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tap(sender:)))
        tap.numberOfTapsRequired = 1
        scroll.addGestureRecognizer(tap)
    }
    
    @objc func tap(sender:UITapGestureRecognizer){

        if sender.state == .ended {

            var touchLocation: CGPoint = sender.location(in: sender.view)
            print(touchLocation)

        }
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
