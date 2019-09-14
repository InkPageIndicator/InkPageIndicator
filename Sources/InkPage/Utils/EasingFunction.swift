//
//  EasingFunction.swift
//  InkPageIndicator-iOS
//
//  Created by tskim on 12/09/2019.
//  Copyright © 2019 Tyler. All rights reserved.
//

import UIKit

enum EasingFunction {
    case easeInSine
    case easeOutSine
    case easeInOutSine
    case easeInQuad
    case easeOutQuad
    case easeInOutQuad
    case easeInCubic
    case easeOutCubic
    case easeInOutCubic
    case easeInQuart
    case easeOutQuart
    case easeInOutQuart
    case easeInQuint
    case easeOutQuint
    case easeInOutQuint
    case easeInExpo
    case easeOutExpo
    case easeInOutExpo
    case easeInCirc
    case easeOutCirc
    case easeInOutCirc
    case easeInBack
    case easeOutBack
    case easeInOutBack
}

extension EasingFunction: CaseIterable { }

// swiftlint:disable switch_case_on_newline
extension EasingFunction: RawRepresentable, CustomStringConvertible {
    var description: String {
        switch self {
        case .easeInSine: return "easeInSine"
        case .easeOutSine: return "easeOutSine"
        case .easeInOutSine: return "easeInOutSine"
        case .easeInQuad: return "easeInQuad"
        case .easeOutQuad: return "easeOutQuad"
        case .easeInOutQuad: return "easeInOutQuad"
        case .easeInCubic: return "easeInCubic"
        case .easeOutCubic: return "easeOutCubic"
        case .easeInOutCubic: return "easeInOutCubic"
        case .easeInQuart: return "easeInQuart"
        case .easeOutQuart: return "easeOutQuart"
        case .easeInOutQuart: return "easeInOutQuart"
        case .easeInQuint: return "easeInQuint"
        case .easeOutQuint: return "easeOutQuint"
        case .easeInOutQuint: return "easeInOutQuint"
        case .easeInExpo: return "easeInExpo"
        case .easeOutExpo: return "easeOutExpo"
        case .easeInOutExpo: return "easeInOutExpo"
        case .easeInCirc: return "easeInCirc"
        case .easeOutCirc: return "easeOutCirc"
        case .easeInOutCirc: return "easeInOutCirc"
        case .easeInBack: return "easeInBack"
        case .easeOutBack: return "easeOutBack"
        case .easeInOutBack: return "easeInOutBack"
        }
    }

    typealias RawValue = (CGFloat, CGFloat, CGFloat, CGFloat)

    init?(rawValue: RawValue) {
        switch rawValue {
        default: return nil
        }
    }
    var rawValue: RawValue {
        switch self {
        case .easeInSine: return (0.47, 0, 0.745, 0.715)
        case .easeOutSine: return (0.39, 0.575, 0.565, 1)
        case .easeInOutSine: return (0.445, 0.05, 0.55, 0.95)
        case .easeInQuad: return (0.55, 0.085, 0.68, 0.53)
        case .easeOutQuad: return (0.25, 0.46, 0.45, 0.94)
        case .easeInOutQuad: return (0.455, 0.03, 0.515, 0.955)
        case .easeInCubic: return (0.55, 0.055, 0.675, 0.19)
        case .easeOutCubic: return (0.215, 0.61, 0.355, 1)
        case .easeInOutCubic: return (0.645, 0.045, 0.355, 1)
        case .easeInQuart: return (0.895, 0.03, 0.685, 0.22)
        case .easeOutQuart: return (0.165, 0.84, 0.44, 1)
        case .easeInOutQuart: return (0.77, 0, 0.175, 1)
        case .easeInQuint: return (0.755, 0.05, 0.855, 0.06)
        case .easeOutQuint: return (0.23, 1, 0.32, 1)
        case .easeInOutQuint: return (0.86, 0, 0.07, 1)
        case .easeInExpo: return (0.95, 0.05, 0.795, 0.035)
        case .easeOutExpo: return (0.19, 1, 0.22, 1)
        case .easeInOutExpo: return (1, 0, 0, 1)
        case .easeInCirc: return (0.6, 0.04, 0.98, 0.335)
        case .easeOutCirc: return (0.075, 0.82, 0.165, 1)
        case .easeInOutCirc: return (0.785, 0.135, 0.15, 0.86)
        case .easeInBack: return (0.6, -0.28, 0.735, 0.045)
        case .easeOutBack: return (0.175, 0.885, 0.32, 1.275)
        case .easeInOutBack: return (0.68, -0.55, 0.265, 1.55)
        }
    }
}

extension UICubicTimingParameters {
    // swiftlint:disable large_tuple
    convenience init(_ param: (CGFloat, CGFloat, CGFloat, CGFloat)) {
        self.init(controlPoint1: CGPoint(x: param.0, y: param.1), controlPoint2: CGPoint(x: param.2, y: param.3))
    }
}

extension CAMediaTimingFunction {
    // swiftlint:disable large_tuple
    convenience init(_ param: (CGFloat, CGFloat, CGFloat, CGFloat)) {
        self.init(controlPoints: Float(param.0), Float(param.1), Float(param.2), Float(param.3))
    }
}
