//
//  UIPageViewPageable.swift
//  Example
//
//  Created by tskim on 15/09/2019.
//  Copyright © 2019 Tyler. All rights reserved.
//

import UIKit

public protocol UIPageViewPageable { }

extension UIPageViewPageable where Self: UIPageViewController {
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

    public var scrollView: UIScrollView? {
        for view in view.subviews {
            if let subView = view as? UIScrollView {
                return subView
            }
        }
        return nil
    }
    public func enableSwipeGesture(_ uipageDataSource: UIPageViewControllerDataSource) {
        self.dataSource = uipageDataSource
    }

    func disableSwipeGesture() {
        self.dataSource = nil
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
