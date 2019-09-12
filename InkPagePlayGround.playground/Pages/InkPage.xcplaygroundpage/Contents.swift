
import UIKit
import PlaygroundSupport
import InkPageIndicator

let size = CGSize(width: 20, height: 20)
UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
let context = UIGraphicsGetCurrentContext()!
//

let frame = CGRect(origin: .zero, size: size)
let beizerPath = UIBeizerPathProvider.instance.inkPage(frame: frame, controlX: 20, spacing: 20)
UIColor.red.setFill()
beizerPath.fill()
//This code must always be at the end of the playground
let image = UIGraphicsGetImageFromCurrentImageContext()!
UIGraphicsEndImageContext()
