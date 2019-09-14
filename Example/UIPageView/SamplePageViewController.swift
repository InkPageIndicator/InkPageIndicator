//
//  SamplePageViewController.swift
//  Example
//
//  Created by tskim on 12/09/2019.
//  Copyright © 2019 Tyler. All rights reserved.
//


import UIKit
import InkPageIndicator

class SamplePageViewController: UIPageViewController, UIPageViewPageable {

    var pages: [UIViewController] = []
    weak var adapter: InkPageControlAdapter?
    private lazy var behavior: InkPageViewScrollingBehavior = InkPageViewScrollingBehavior(self, adapter: adapter)
    override init(
        transitionStyle style: UIPageViewController.TransitionStyle,
        navigationOrientation: UIPageViewController.NavigationOrientation,
        options: [UIPageViewController.OptionsKey: Any]? = nil
    ) {
        super.init(transitionStyle: .scroll, navigationOrientation: navigationOrientation, options: options)
    }

    required init?(coder: NSCoder) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.enableSwipeGesture(self)
        self.scrollView?.delegate = self
        self.delegate = self
        setViewControllers([pages[0]], direction: .forward, animated: true)
    }
}

extension SamplePageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
        if currentIndex == 0 {
            return nil
        }
        let previousIndex = currentIndex - 1

        if previousIndex < 0 {
            return nil
        } else {
            return pages[previousIndex]
        }
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
        let nextIndex = currentIndex + 1

        if nextIndex >= pages.count {
            return nil
        } else {
            return pages[nextIndex]
        }
    }
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pages.count
    }
}
extension SamplePageViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        self.behavior.pageViewController(pageViewController, willTransitionTo: pendingViewControllers)
    }
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted
        completed: Bool) {
        self.behavior.pageViewController(
            pageViewController,
            didFinishAnimating: finished,
            previousViewControllers: previousViewControllers,
            transitionCompleted: completed
        )
    }
}

extension SamplePageViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.behavior.scrollViewDidScroll(scrollView)
    }
}

extension SamplePageViewController: InkPagePageViewBridge {
    func pageFirstIndex(viewControllers: [UIViewController]) -> Int? {
        pages.firstIndex(where: { vc in vc == viewControllers.first })
    }
    
    var itemCount: Int {
        return pages.count
    }
}


