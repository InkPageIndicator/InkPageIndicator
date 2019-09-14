//
//  CABasicAnimation+Init.swift
//  InkPageIndicator-iOS
//
//  Created by tskim on 12/09/2019.
//  Copyright © 2019 Tyler. All rights reserved.
//

import UIKit

extension CABasicAnimation {
    static func createAnimationLayer(
        withDuration duration: TimeInterval,
        delay: TimeInterval,
        animationKeyPath: String,
        timingFunction: CAMediaTimingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut),
        fromValue from: Any?,
        toValue to: Any?
        ) -> CAAnimation {
        let animation = CABasicAnimation(keyPath: animationKeyPath)
        animation.beginTime = CACurrentMediaTime() + delay
        animation.fromValue = from
        animation.toValue = to
        animation.timingFunction = timingFunction
        animation.isRemovedOnCompletion = false
        animation.duration = duration
        animation.fillMode = .forwards
        return animation
    }
}
