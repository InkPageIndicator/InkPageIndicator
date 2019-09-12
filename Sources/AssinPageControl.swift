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

public struct DotColorState {
    let isSelected: Bool
    let selectedColor: UIColor
    let normalColor: UIColor
}

extension DotColorState {
    var stateColor: UIColor {
        return isSelected ? selectedColor : normalColor
    }
}

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

@IBDesignable open class AssinPageControl: UIControl {

    fileprivate static let dotName = "dot"

    private var dots: [Dot] = []

    private var cacheFrame: CGRect = .zero

    private lazy var displayLink: CADisplayLink = {
        CADisplayLink(target: self, selector: #selector(handleUpdate))
    }()
    
    private var animationStartDate = Date()
    private let duration = 5.0
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

    @IBInspectable open var progress: CGFloat = 0 {
        didSet {
            Logger.log(message: "progress: \(progress)")
        }
    }
    @IBInspectable open var dotSize: CGSize = CGSize(width: 16, height: 16) {
        didSet {
        }
    }

    private var _prevPage = 0
    @IBInspectable open var currentPage: Int = 0 {
        didSet {
            if _prevPage == currentPage {
                return
            }
            updateDots()
            _prevPage = currentPage
        }
    }

    @IBInspectable open var spacing: CGFloat = 30 {
        didSet {
            setNeedsDisplay()
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
        cacheFrame = self.frame
        self.layoutIfNeeded()
    }

    public override init(frame: CGRect) {
        self.arranger = CenterLayoutArranger()
        super.init(frame: frame)
        cacheFrame = frame
    }

    deinit {
        displayLink.invalidate()
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        if isChangedSize() {
            updateDots()
            cacheFrame = self.frame
        }
    }

    private func isChangedSize() -> Bool {
        return !cacheFrame.equalTo(self.frame)
    }

    @objc func handleUpdate(displaylink: CADisplayLink) {
        let now = Date()
        let elapsedTime = now.timeIntervalSince(animationStartDate) // 애니매이션이 시작한 후 부터 지난 시간
        if elapsedTime > duration {
            animationStartDate = Date()
            return
        }
    }
    
    private func updateDots() {
        Logger.log(message: "updateDots")
        self.layer.sublayers?.removeAll {
            $0.name == AssinPageControl.dotName
        }

        dots = (0..<numberOfPages).map { i in
            let dotColorState = DotColorState(
                isSelected: currentPage == i,
                selectedColor: currentPageIndicatorTintColor,
                normalColor: pageIndicatorTintColor
            )
            let dotType = DotType.basic(dotSize)

            return Dot(
                type: dotType,
                layer: dotType.createLayer(dotColorState.stateColor)
            )
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
    }
}

private extension CALayer {
    func findLayerByKey(key: String) -> [CALayer] {
        return self.sublayers?.filter {
            $0.name == key
        } ?? []
    }
}
