//
//  AssinPageControlPageTransitionDelegate.swift
//  InkPageIndicator-iOS
//
//  Created by tskim on 13/09/2019.
//  Copyright © 2019 Tyler. All rights reserved.
//

import Foundation

public protocol AssinPageControlPageTransitionDelegate: class {
    func beginAnimation(from: Int, to: Int)
    func endAnimation()
    func updateProgress(progress: Double)
}
