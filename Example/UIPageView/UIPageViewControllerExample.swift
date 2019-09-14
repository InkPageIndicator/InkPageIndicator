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
class UIPageViewControllerExample: UIViewController, StoryboardInitializable, WrapInkPageControlAdapter {
    // MARK: Properties

    @IBOutlet weak var pageViewController: UIView!
    @IBOutlet weak var pageControl: AssinPageControl!
    
    internal lazy var pageContoller: AssinPageController? = {
       return pageControl
    }()
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
            page.adapter = self
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}
