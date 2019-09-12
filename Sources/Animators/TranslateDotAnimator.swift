//
//  TranslateDotAnimator.swift
//  InkPageIndicator-iOS
//
//  Created by tskim on 13/09/2019.
//  Copyright © 2019 Tyler. All rights reserved.
//

import UIKit

class TranslateDotAnimator {
    func animate(
        layer: CALayer,
        dX: CGFloat,
        timingFunction: CAMediaTimingFunction = CAMediaTimingFunction(EasingFunction.easeInCubic.rawValue),
        before: (() -> Void)? = nil,
        completion: (() -> Void)? = nil
    ) {
        layer.removeAllAnimations()

        CATransaction.begin()
        before?()
        // CATransaction completion being called immediately
        // https://stackoverflow.com/questions/19975938/catransaction-completion-being-called-immediately
        CATransaction.setCompletionBlock {
            completion?()
        }
        let translateX = CABasicAnimation.createAnimationLayer(
            withDuration: 0.3,
            delay: 0,
            animationKeyPath: "transform.translation.x",
            timingFunction: timingFunction,
            fromValue: 0,
            toValue: dX)
        layer.add(translateX, forKey: "page.translate.x")

        CATransaction.commit()

    }
}
