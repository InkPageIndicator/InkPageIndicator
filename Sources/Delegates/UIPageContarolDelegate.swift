//
//  UIPageContarolDelegate.swift
//  Example
//
//  Created by tskim on 12/09/2019.
//  Copyright © 2019 Tyler. All rights reserved.
//

import Foundation

protocol UIPageContarolDelegate: class {
    func pageControl(transitionCompleted page: Int)
    func pageControl(startPage: Int, endPage: Int)
    func pageControl(progress: Double)
}
