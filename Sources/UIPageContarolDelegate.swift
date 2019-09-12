//
//  UIPageContarolDelegate.swift
//  Example
//
//  Created by tskim on 12/09/2019.
//  Copyright © 2019 Tyler. All rights reserved.
//

import Foundation

 @objc protocol UIPageContarolDelegate: class {
    @objc optional func pageControl(curPage: Int)
    @objc optional func pageControl(progress: Double)
}
