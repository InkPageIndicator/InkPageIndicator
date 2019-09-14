//
//  AssinPageControlPageTransitionDelegate.swift
//  InkPageIndicator-iOS
//
//  Created by tskim on 13/09/2019.
//  Copyright © 2019 Tyler. All rights reserved.
//

import Foundation

public protocol AssinPageController: class {
    func beginAnimation(from: Int, to: Int)
    func cancelAnimation()
    func endAnimation(page: Int)
    func updateProgress(progress: Double)
}
