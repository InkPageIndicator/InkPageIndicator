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
    @IBOutlet weak var pageControl: UIPageControl!
    /// View did load

    private var pages =  [
        ViewController.generateViewController(),
        ViewController.generateViewController(),
        ViewController.generateViewController()
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
}

extension ViewController {

    static let colors = [UIColor.red, UIColor.cyan, UIColor.orange, UIColor.green, UIColor.magenta, UIColor.yellow]

    class func generateViewController() -> UIViewController {
        let vc = ChildViewController()
        vc.view.backgroundColor = colors.randomElement()
        return vc
    }
}

extension ViewController: UIPageContarolDelegate {
    func pageControl(curPage: Int) {
        self.pageControl.currentPage = curPage
    }
}
