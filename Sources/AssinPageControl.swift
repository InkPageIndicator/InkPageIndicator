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

public protocol AssinPageControlPageTransitionDelegate: class {
    func beginAnimation(from: Int, to: Int)
    func endAnimation()
    func updateProgress(progress: Double)
}
@IBDesignable open class AssinPageControl: UIControl {

    fileprivate static let dotName = "dot"

    private let translateAnimator = TranslateDotAnimator()
    private var _prevPage = 0

    private var dots: [Dot] = []

    private var cacheFrame: CGRect = .zero

    private var fromAnimationLayer: CAShapeLayer?
    private var toAnimationLayer: CAShapeLayer?

    private var displayLink: CADisplayLink?

    private var animationStartDate = Date()

    open var transitionDuration: TimeInterval = 5.0

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
//            updateProgress(for: progress)
        }
    }

    @IBInspectable open var dotSize: CGSize = CGSize(width: 16, height: 16) {
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
                    timingFunction: pageTimingFunction,
                    completion: {
                        self.updateDots()
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
        displayLink?.invalidate()
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
        let elapsedTime = now.timeIntervalSince(animationStartDate)
        if elapsedTime > transitionDuration {
            Logger.log(message: "handleUpdate: reset elapsedtime")
            animationStartDate = Date()
            return
        }
//        Logger.log(message: "handleUpdate: run animation")
        let percentage = elapsedTime / transitionDuration
        updateProgress(for: percentage)
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

    internal var lastPage: Int = 0
    private var radius: CGFloat = 4
    fileprivate var diameter: CGFloat {
        return radius * 2
    }
    var padding: CGFloat = 5

    func updateProgress(for progress: Double) {
//        print("!!!!!!!!! updateProgress: \(progress)")
        guard progress >= 0,
            let from = fromAnimationLayer,
            let to = toAnimationLayer,
            numberOfPages > 1 else {
                return
        }
        let maxX = (from.frame.width / 2) + CGFloat(spacing / 2)
        let controlX = CGFloat(progress) * maxX
        
        UIGraphicsBeginImageContextWithOptions(from.frame.size, false, 0.0)
        if let _ = UIGraphicsGetCurrentContext() {
            from.path = UIBeizerPathProvider.instance.inkPage(frame: from.frame, controlX: controlX).cgPath
            from.fillColor = pageIndicatorTintColor.cgColor
            UIGraphicsEndImageContext()
        }
    }
}

extension AssinPageControl {
    private func getColorState(page: Int) -> UIColor {
        return currentPage == page ? currentPageIndicatorTintColor : pageIndicatorTintColor
    }
}

extension AssinPageControl: AssinPageControlPageTransitionDelegate {
    public func updateProgress(progress: Double) {
        self.progress = progress
    }

    public func endAnimation() {
        fromAnimationLayer = nil
        toAnimationLayer = nil
        displayLink?.invalidate()
        displayLink = nil
    }

    public func beginAnimation(from: Int, to: Int) {

        if let leftFrame = self.dots[safe: from]?.layer.frame,
            let rightFrame = self.dots[safe: to]?.layer.frame {
            let from = CAShapeLayer()
            from.frame = leftFrame
            fromAnimationLayer = from
            
            self.layer.addSublayer(from)
            
            
            toAnimationLayer = CAShapeLayer()
            toAnimationLayer?.frame = rightFrame

            displayLink?.invalidate()
            displayLink = CADisplayLink(target: self, selector: #selector(handleUpdate))
            displayLink?.add(to: .main, forMode: .common)
        }
    }
}
