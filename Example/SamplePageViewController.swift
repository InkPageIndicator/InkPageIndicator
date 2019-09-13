//
//  SamplePageViewController.swift
//  Example
//
//  Created by tskim on 12/09/2019.
//  Copyright © 2019 Tyler. All rights reserved.
//


import UIKit

class SamplePageViewController: UIPageViewController {


    private var currentPage = 0
    
    var pages: [UIViewController] = []
    weak var controlDelegate: UIPageContarolDelegate?
    
    override init(
        transitionStyle style: UIPageViewController.TransitionStyle,
        navigationOrientation: UIPageViewController.NavigationOrientation,
        options: [UIPageViewController.OptionsKey : Any]? = nil
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
        setViewControllers([pages[currentPage]], direction: .forward, animated: true)
        controlDelegate?.pageControl(completePage: currentPage)
    }
}
//
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
        if let page = pages.firstIndex(where: { vc in vc == pendingViewControllers.first }) {
            controlDelegate?.pageControl(willStartPage: currentPage, toPage: page)
            currentPage = page
        }
    }
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            controlDelegate?.pageControl(completePage: currentPage)
        } else {
            if let page = pages.firstIndex(where: { vc in vc == previousViewControllers.first }) {
                currentPage = page
            }
        }
        controlDelegate?.pageControl(finished: finished)
    }
}

extension SamplePageViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let numberOfPages = pages.count
        let total = scrollView.contentSize.width - scrollView.bounds.width
        let offset = scrollView.contentOffset.x
        let percent = Double(offset / total)
        
        let progress = percent * Double(numberOfPages - 1)
        
        
        var newProgress = progress
        newProgress = abs(1 - progress)
        controlDelegate?.pageControl(progress: newProgress)
    }
}
