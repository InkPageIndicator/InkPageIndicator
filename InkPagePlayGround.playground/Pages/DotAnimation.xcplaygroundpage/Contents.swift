
import UIKit
import PlaygroundSupport
import InkPageIndicator

class MyViewController : UIViewController {
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white
        
        let leftAnimView = UIView()
        leftAnimView.frame =  CGRect(x: 150, y: 200, width: 50, height: 50)
        let layer = DotType.basic(leftAnimView.bounds.size).createLayer(UIColor.yellow)
        

        leftAnimView.layer.addSublayer(layer)
        view.addSubview(leftAnimView)
        layer.frame
        self.view = view
    }
    
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()

