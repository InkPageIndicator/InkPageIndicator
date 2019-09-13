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
class UIPageViewControllerExample: UIViewController {

    // MARK: Properties

    @IBOutlet weak var pageViewController: UIView!
    @IBOutlet weak var pageControl: AssinPageControl!
    /// View did load

    private var pages = [
        generateViewController(ChildModel.dummy[0]),
        generateViewController(ChildModel.dummy[1]),
        generateViewController(ChildModel.dummy[2])
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
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

extension UIPageViewControllerExample: UIPageContarolDelegate {
    func pageControl(completePage: Int) {
        self.pageControl.currentPage = completePage
    }
    func pageControl(finished: Bool) {
        self.pageControl?.endAnimation()
    }
    func pageControl(willStartPage: Int, toPage: Int) {
        self.pageControl?.beginAnimation(from: willStartPage, to: toPage)
    }
    func pageControl(progress: Double) {
        self.pageControl?.updateProgress(progress: progress)
    }
}
