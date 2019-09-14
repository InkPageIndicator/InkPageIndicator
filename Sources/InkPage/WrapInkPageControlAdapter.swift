//
//  WrapInkPageControlAdapter.swift
//  InkPageIndicator
//
//  Created by tskim on 15/09/2019.
//  Copyright © 2019 Tyler. All rights reserved.
//

import Foundation

public protocol WrapInkPageControlAdapter: InkPageControlAdapter {
    var pageContoller: AssinPageController? { get }
}

extension WrapInkPageControlAdapter where Self: InkPageControlAdapter {
    public func pageControl(transitionCompleted page: Int) {
        pageContoller?.endAnimation(page: page)
    }
    public func pageControl(startPage: Int, endPage: Int) {
        pageContoller?.beginAnimation(from: startPage, to: endPage)
    }
    public func pageControl(progress: Double) {
        pageContoller?.updateProgress(progress: progress)
    }
}
