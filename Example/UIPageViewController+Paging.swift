//
//  UIPageViewController+Paging.swift
//  Example
//
//  Created by tskim on 12/09/2019.
//  Copyright © 2019 Tyler. All rights reserved.
//

import UIKit

extension UIPageViewController {
    
    var isPagingEnabled: Bool {
        get {
            var isEnabled: Bool = true
            for view in view.subviews {
                if let subView = view as? UIScrollView {
                    isEnabled = subView.isScrollEnabled
                }
            }
            return isEnabled
        }
        set {
            for view in view.subviews {
                if let subView = view as? UIScrollView {
                    subView.isScrollEnabled = newValue
                }
            }
        }
    }
    
    var scrollView: UIScrollView? {
        for view in view.subviews {
            if let subView = view as? UIScrollView {
                return subView
            }
        }
        return nil
    }
    func enableSwipeGesture(_ uipageDataSource: UIPageViewControllerDataSource) {
        self.dataSource = uipageDataSource
    }
    
    func disableSwipeGesture() {
        self.dataSource = nil
    }
    
    @discardableResult
    func nextPage(animated: Bool = true, completion: ((Bool) -> Void)? = nil) -> UIViewController? {
        if let currentViewController = viewControllers?[0] {
            if let nextPage = dataSource?.pageViewController(self, viewControllerAfter: currentViewController) {
                setViewControllers([nextPage], direction: .forward, animated: animated, completion: completion)
                return nextPage
            }
        }
        return nil
    }
    func prevPage(animated: Bool = true, completion: ((Bool) -> Void)? = nil) -> UIViewController? {
        if let currentViewController = viewControllers?[0] {
            if let prevPage = dataSource?.pageViewController(self, viewControllerBefore: currentViewController) {
                setViewControllers([prevPage], direction: .reverse, animated: animated, completion: completion)
                return prevPage
            }
        }
        return nil
    }
    var isFirstPage: Bool {
        if let currentViewController = viewControllers?[0] {
            if dataSource?.pageViewController(self, viewControllerBefore: currentViewController) != nil {
                return false
            }
        }
        return true
    }
}
