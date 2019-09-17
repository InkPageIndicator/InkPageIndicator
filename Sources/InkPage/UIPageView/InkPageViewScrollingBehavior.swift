//
//  InkPageViewScrollingBehavior.swift
//  InkPageIndicator
//
//  Created by tskim on 15/09/2019.
//  Copyright © 2019 Tyler. All rights reserved.
//

import UIKit

public final class InkPageViewScrollingBehavior: NSObject {
    private var currentPage = 0
    private var adapter: InkPageControlAdapter?
    private unowned let bridge: InkPagePageViewBridge

    public init(_ bridge: InkPagePageViewBridge, adapter: InkPageControlAdapter?) {
        self.bridge = bridge
        self.adapter = adapter
    }
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let numberOfPages = self.bridge.itemCount
        let total = scrollView.contentSize.width - scrollView.bounds.width
        let offset = scrollView.contentOffset.x
        let percent = Double(offset / total)

        let progress = percent * Double(numberOfPages - 1)

        var newProgress = progress
        newProgress = abs(1 - progress)
        adapter?.pageControl(progress: newProgress)
    }
    public func pageViewController(
        _ pageViewController: UIPageViewController,
        willTransitionTo pendingViewControllers: [UIViewController]
    ) {
        if let page = self.bridge.pageFirstIndex(viewControllers: pendingViewControllers) {
            adapter?.pageControl(startPage: currentPage, endPage: page)
            currentPage = page
        }
    }
    public func pageViewController(
        _ pageViewController: UIPageViewController,
        didFinishAnimating finished: Bool,
        previousViewControllers: [UIViewController],
        transitionCompleted completed: Bool
    ) {
        if completed {
            adapter?.pageControl(transitionCompleted: currentPage)
        } else {
            if let page = self.bridge.pageFirstIndex(viewControllers: previousViewControllers) {
                currentPage = page
            }
        }
    }
}
