//
//  AssinPageControlPageTransitionDelegate.swift
//  InkPageIndicator-iOS
//
//  Created by tskim on 13/09/2019.
//  Copyright © 2019 Tyler. All rights reserved.
//

import Foundation

@objc public protocol AssinPageControlPageTransitionDelegate: class {
    @objc optional func beginAnimation(from: Int, to: Int)
    @objc optional func endAnimation()
    @objc optional func updateProgress(progress: Double)
}
