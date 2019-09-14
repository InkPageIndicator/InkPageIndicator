//
//  UIPageControlAdapter.swift
//  InkPageIndicator-iOS
//
//  Created by tskim on 14/09/2019.
//  Copyright © 2019 Tyler. All rights reserved.
//

import Foundation

public protocol InkPageControlAdapter: class {
    func pageControl(transitionCompleted page: Int)
    func pageControl(startPage: Int, endPage: Int)
    func pageControl(progress: Double)
}
