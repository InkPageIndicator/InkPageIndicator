//
//  DotType.swift
//  InkPageIndicator-iOS
//
//  Created by tskim on 13/09/2019.
//  Copyright © 2019 Tyler. All rights reserved.
//

import UIKit

struct Dot {
    let type: DotType
    let layer: CALayer
}
public enum DotType {
    case basic(CGSize)
    
    public func createImage(_ color: UIColor) -> UIImage? {
        switch self {
        case let .basic(size):
            return UIImage.dotEllipse(size: size, color: color)
        }
    }
    
    public func createLayer(_ color: UIColor) -> CALayer {
        let layer = CALayer()
        switch self {
        case let .basic(size):
            layer.contents = UIImage.dotEllipse(size: size, color: color)?.cgImage
        }
        return layer
    }
}
