//
//  InkPageIndicator.swift
//  InkPageIndicator
//
//  Created by Tyler on 2019. 9. 12..
//  Copyright © 2019 Tyler. All rights reserved.
//

// Include Foundation
@_exported import Foundation
import UIKit

public enum DotType {
    case basic(CGSize, UIColor)

    public var image: UIImage? {
        switch self {
        case let .basic(size, color):
            return UIImage.dotEllipse(size: size, color: color)
        }
    }

    public var layer: CALayer {
        let layer = CALayer()
        switch self {
        case let .basic(size, color):
            layer.contents = UIImage.dotEllipse(size: size, color: color)?.cgImage
        }
        return layer
    }
}

@IBDesignable open class AssinPageControl: UIControl {

    private static let dotName = "dot"

    private var dots: [DotType] = []

    @IBInspectable open var numberOfPages: Int = 0 {
        didSet {
            updateDots()
        }
    }

    @IBInspectable open var currentPageIndicatorTintColor: UIColor = UIColor.black {
        didSet {
        }
    }

    @IBInspectable open var pageIndicatorTintColor: UIColor = UIColor.lightGray {
        didSet {
        }
    }

    @IBInspectable open var dotSize: CGSize = CGSize(width: 16, height: 16) {
        didSet {
        }
    }

    @IBInspectable open var currentPage: Int = 0 {
        didSet {
            Logger.log(message: "currentPage: \(currentPage)")
        }
    }

    @IBInspectable open var spacing: CGFloat = 20 {
        didSet {
            Logger.log(message: "currentPage: \(currentPage)")
        }
    }

    private let arranger: CenterLayoutArranger

    public init(_ arranger: CenterLayoutArranger) {
        self.arranger = arranger
        super.init(frame: .zero)
    }

    required public init?(coder aDecoder: NSCoder) {
        self.arranger = CenterLayoutArranger()
        super.init(coder: aDecoder)
    }

    public override init(frame: CGRect) {
        self.arranger = CenterLayoutArranger()
        super.init(frame: frame)
    }

    open override func layoutSubviews() {
        super.layoutSubviews()
    }

    private func update() {

    }

    private func updateDots() {
        Logger.log(message: "updateDots")
        self.layer.sublayers?.removeAll {
            $0.name == AssinPageControl.dotName
        }

        let color = pageIndicatorTintColor
        dots = (0..<numberOfPages).map { _ in
            DotType.basic(dotSize, color)
        }

        let frames = self.arranger.arrange(
            viewSize: self.frame,
            childSizes: (0..<numberOfPages).map { _ in dotSize },
            interval: spacing
        )

        for (i, dot) in dots.enumerated() {
            let layer = dot.layer
            layer.frame = frames[i]
            layer.name = AssinPageControl.dotName
            self.layer.addSublayer(layer)
        }
        setNeedsLayout()
    }
}
