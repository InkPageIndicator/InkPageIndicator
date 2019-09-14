//
//  RxUIPageViewController.swift
//  Example
//
//  Created by tskim on 14/09/2019.
//  Copyright © 2019 Tyler. All rights reserved.
//

import UIKit
import InkPageIndicator
import RxSwift
// MARK: - ViewController

/// The ViewController
class RxUIPageViewControllerExample: UIViewController, StoryboardInitializable {

    // MARK: Properties

    @IBOutlet weak var pageViewController: UIView!
    @IBOutlet weak var pageControl: AssinPageControl!

    private var disposeBag = DisposeBag()
    private lazy var pageContoller: AssinPageController = {
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

        Observable.just((1, 1))
            .bind(to: pageControl.rx.beginAnimation)
            .disposed(by: disposeBag)

        Observable.just(1)
            .bind(to: pageControl.rx.endAnimation)
            .disposed(by: disposeBag)
        
        Observable.just(1.0)
            .bind(to: pageControl.rx.progress)
            .disposed(by: disposeBag)
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

extension RxUIPageViewControllerExample: UIPageControlAdapter {
    func pageControl(transitionCompleted page: Int) {
        pageContoller.endAnimation(page: page)
    }
    func pageControl(startPage: Int, endPage: Int) {
        pageContoller.beginAnimation(from: startPage, to: endPage)
    }
    func pageControl(progress: Double) {
        pageContoller.updateProgress(progress: progress)
    }
}
