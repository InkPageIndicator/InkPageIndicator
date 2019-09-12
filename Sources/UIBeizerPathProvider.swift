//
//  InkPageBeizerCreator.swift
//  InkPageIndicator-iOS
//
//  Created by tskim on 13/09/2019.
//  Copyright © 2019 Tyler. All rights reserved.
//

import UIKit

public class UIBeizerPathProvider {

    public static let instance = UIBeizerPathProvider()

    private init() { }
    public func inkPage(frame: CGRect, controlX: CGFloat, spacing: CGFloat) -> UIBezierPath {
        let bezierPath = UIBezierPath()
        var temp = frame
        // start point
        temp.origin.x = frame.width / 2
        temp.origin.y = 0
        let minX: CGFloat = 0
        let minY: CGFloat = 0
        
        bezierPath.move(to: .zero)
        
        // draw line to bottom
        bezierPath.addLine(to: CGPoint(x: minX, y: temp.height))
        // draw beizer bottom - right
        /*
         |
         |
         |             end
         |
         |  start
         */
        bezierPath.addCurve (
            to: CGPoint (x: controlX, y: temp.height / 2),
            controlPoint1: CGPoint (x: minX, y: temp.height),
            controlPoint2: CGPoint (x: controlX, y: temp.height)
        )

        // draw beizer top - left
        /*
         |end
         |
         |     start
         |    /
         |  /
         */
        bezierPath.addCurve(
            to: CGPoint (x: minX, y: minY),
            controlPoint1: CGPoint (x: controlX, y: minY),
            controlPoint2: CGPoint (x: minX, y: minY)
        )
        bezierPath.close()
        UIColor.gray.setFill()
        bezierPath.fill()
        return bezierPath
    }
}
