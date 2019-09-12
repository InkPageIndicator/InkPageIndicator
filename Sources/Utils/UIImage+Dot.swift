//
//  UIImage+Dot.swift
//  Example
//
//  Created by tskim on 12/09/2019.
//  Copyright © 2019 Tyler. All rights reserved.
//

import UIKit

public extension UIImage {
    class func dotEllipse(size: CGSize, color: UIColor) -> UIImage? {

        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        context.addEllipse(in: CGRect(origin: CGPoint(x: 0, y: 0), size: size))
        context.fillPath()
        color.setFill()
//        path.fill()
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        return image
    }
}
