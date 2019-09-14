//
//  UIPageContarolDelegate.swift
//  Example
//
//  Created by tskim on 12/09/2019.
//  Copyright © 2019 Tyler. All rights reserved.
//

import Foundation

protocol UIPageContarolDelegate: class {
    func pageControl(completePage: Int)
    func pageControl(startPage: Int, endPage: Int)
    func pageControl(finished: Bool)
    func pageControl(progress: Double)
}
