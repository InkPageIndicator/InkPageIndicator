//
//  ViewController.swift
//  Example
//
//  Created by Tyler on 2019. 9. 12..
//  Copyright © 2019 Tyler. All rights reserved.
//

import UIKit
import InkPageIndicator

// MARK: - ViewController

/// The ViewController
class ViewController: UIViewController {

    // MARK: Properties

    @IBOutlet weak var pageViewController: UIView!
    @IBOutlet weak var pageControl: AssinPageControl!
    /// View did load

    private weak var pageControlTransitionDelegate: AssinPageControlPageTransitionDelegate?
    
    private var pages =  [
        ViewController.generateViewController(UIColor.yellow),
        ViewController.generateViewController(UIColor.orange),
        ViewController.generateViewController(UIColor.purple)
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        pageControlTransitionDelegate = pageControl
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        pageControl.numberOfPages = pages.count
        pageControl.currentPageIndicatorTintColor = UIColor.black
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if let page = segue.destination as? SamplePageViewController {
            page.pages = pages
            page.controlDelegate = self
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}

extension ViewController {

    class func generateViewController(_ color: UIColor) -> UIViewController {
        let vc = ChildViewController()
        vc.view.backgroundColor = color
        return vc
    }
}

extension ViewController: UIPageContarolDelegate {
    func pageControl(completePage: Int) {
        self.pageControl.currentPage = completePage
    }
    func pageControl(finished: Bool) {
        self.pageControlTransitionDelegate?.endAnimation()
    }
    func pageControl(willStartPage: Int, toPage: Int) {
        self.pageControlTransitionDelegate?.beginAnimation(from: willStartPage, to: toPage)
    }
    func pageControl(progress: Double) {
        self.pageControlTransitionDelegate?.updateProgress(progress: progress)
    }
}
