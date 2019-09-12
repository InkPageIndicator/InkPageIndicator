//
//  TranslateDotAnimator.swift
//  InkPageIndicator-iOS
//
//  Created by tskim on 13/09/2019.
//  Copyright © 2019 Tyler. All rights reserved.
//

import UIKit

class TranslateDotAnimator {
    func animate(dot: Dot, dX: CGFloat, completion: (() -> Void)? = nil) {
        dot.layer.removeAllAnimations()
        CATransaction.begin()
        // CATransaction completion being called immediately
        // https://stackoverflow.com/questions/19975938/catransaction-completion-being-called-immediately
        CATransaction.setCompletionBlock {
            completion?()
            dot.layer.zPosition = 0
        }
        let translateX = CABasicAnimation.createAnimationLayer(
            withDuration: 0.3,
            delay: 0,
            animationKeyPath: "transform.translation.x",
            timingFunction: CAMediaTimingFunction(EasingFunction.easeInCubic.rawValue),
            fromValue: 0,
            toValue: dX)
        dot.layer.add(translateX, forKey: "page.translate.x")
        dot.layer.zPosition = 1
        
        CATransaction.commit()
        
    }
}
