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

@IBDesignable open class AssinPageControl: UIControl {

    fileprivate static let dotName = "dot"

    private let translateAnimator = TranslateDotAnimator()
    private var _prevPage = 0

    private var dots: [Dot] = []

    private var cacheFrame: CGRect = .zero

    private var fromAnimationLayer: CAShapeLayer?
    private var toAnimationLayer: CAShapeLayer?

    @IBInspectable open var numberOfPages: Int = 0 {
        didSet {
            updateDots()
        }
    }

    @IBInspectable open var currentPageIndicatorTintColor: UIColor = UIColor.black {
        didSet {
            updateDots()
        }
    }

    @IBInspectable open var pageIndicatorTintColor: UIColor = UIColor.lightGray {
        didSet {
            updateDots()
        }
    }

    open var pageTimingFunction: CAMediaTimingFunction
        = CAMediaTimingFunction(EasingFunction.easeInCubic.rawValue)

    @IBInspectable open var progress: Double = 0 {
        didSet {
            updateProgress(for: progress)
        }
    }

    @IBInspectable open var dotSize: CGSize = CGSize(width: 10, height: 10) {
        didSet {
            updateDots()
        }
    }

    @IBInspectable open var currentPage: Int = 0 {
        didSet {
            if _prevPage == currentPage {
                return
            }

            if let selectedDot = self.dots[safe: _prevPage] {

                // buffering layer
                let bufferLayer = selectedDot.type.createLayer(currentPageIndicatorTintColor)
                bufferLayer.frame = selectedDot.layer.frame
                self.layer.addSublayer(bufferLayer)

                var dX: CGFloat = 0
                if _prevPage < currentPage {
                    dX = selectedDot.layer.frame.width + self.spacing
                } else if _prevPage > currentPage {
                    dX = -(selectedDot.layer.frame.width + self.spacing)
                } else {
                    return
                }
                selectedDot.layer.zPosition = 1
                translateAnimator.animate(
                    layer: bufferLayer,
                    dX: dX,
                    duration: 0.2,
                    timingFunction: pageTimingFunction,
                    completion: {
                        bufferLayer.removeAllAnimations()
                        bufferLayer.removeFromSuperlayer()
                        self.updateDots()
                        self.clearAnimations()
                    })
            }
            _prevPage = currentPage
        }
    }

    @IBInspectable open var spacing: CGFloat = 50 {
        didSet {
            updateDots()
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
        clearAnimations()
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

    private func updateDots() {
        Logger.log(message: "updateDots")
        self.layer.sublayers?.removeAll {
            $0.name == AssinPageControl.dotName
        }

        dots = (0..<numberOfPages).map { i in
            let dotType = DotType.basic(dotSize)

            return Dot(
                type: dotType,
                layer: dotType.createLayer(getColorState(page: i))
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

    func updateProgress(for progress: Double) {
        guard progress >= 0,
            let from = fromAnimationLayer,
            let to = toAnimationLayer,
            numberOfPages > 1 else {
                return
        }
        let maxX = from.frame.width + spacing
        let controlX = CGFloat(progress) * maxX
        
        updateInkShapeLayer(shapeLayer: from, controlX: controlX)
        updateInkShapeLayer(shapeLayer: to, controlX: -controlX)
    }
    
    private func updateInkShapeLayer(shapeLayer: CAShapeLayer, controlX: CGFloat) {
        UIGraphicsBeginImageContextWithOptions(shapeLayer.frame.size, false, 0.0)
        if UIGraphicsGetCurrentContext() != nil {
            shapeLayer.path = UIBeizerPathProvider.instance.inkPage(frame: shapeLayer.frame, controlX: controlX).cgPath
            shapeLayer.fillColor = pageIndicatorTintColor.cgColor
            UIGraphicsEndImageContext()
        }
    }
    private func getColorState(page: Int) -> UIColor {
        return currentPage == page ? currentPageIndicatorTintColor : pageIndicatorTintColor
    }
}

extension AssinPageControl: AssinPageController {
    public func endAnimation(page: Int) {
        self.currentPage = page
    }
    
    public func updateProgress(progress: Double) {
        if progress <= 0 {
            return
        }
        self.progress = progress
    }
    public func cancelAnimation() {
        clearAnimations()
    }
    public func beginAnimation(from: Int, to: Int) {
        clearAnimations()
        if from == to {
            return
        }
        if let leftFrame = self.dots[safe: from]?.layer.frame,
            let rightFrame = self.dots[safe: to]?.layer.frame {
            if from < to {
                let from = makeInkShapeLayer(dotFrame: leftFrame)
                self.layer.addSublayer(from)
                fromAnimationLayer = from
                
                let to = makeInkShapeLayer(dotFrame: rightFrame)
                self.layer.addSublayer(to)
                toAnimationLayer = to
            } else {
                let from = makeInkShapeLayer(dotFrame: rightFrame)
                self.layer.addSublayer(from)
                fromAnimationLayer = from
                
                let to = makeInkShapeLayer(dotFrame: leftFrame)
                self.layer.addSublayer(to)
                toAnimationLayer = to
            }
        }
    }
    private func makeInkShapeLayer(dotFrame: CGRect) -> CAShapeLayer {
        let layer = CAShapeLayer()
        layer.frame = dotFrame
        // shift half width
        layer.frame.origin.x += dotFrame.width / 2
        layer.zPosition = -1
        return layer
    }
    
    private func clearAnimations() {
        CATransaction.flush()
        self.fromAnimationLayer?.removeAllAnimations()
        self.fromAnimationLayer?.removeFromSuperlayer()
        self.fromAnimationLayer = nil
        
        self.toAnimationLayer?.removeAllAnimations()
        self.toAnimationLayer?.removeFromSuperlayer()
        self.toAnimationLayer = nil
    }
}
