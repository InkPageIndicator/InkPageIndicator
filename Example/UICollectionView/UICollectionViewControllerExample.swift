//
//  UICollectionViewExample.swift
//  Example
//
//  Created by tskim on 13/09/2019.
//  Copyright © 2019 Tyler. All rights reserved.
//

import InkPageIndicator
import UIKit

class UICollectionViewControllerExample: UIViewController, StoryboardInitializable {

    lazy var flowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        return flowLayout
    }()

    @IBOutlet weak var collectionView: UICollectionView!

    fileprivate var items = ChildModel.dummy

    @IBOutlet weak var pageControl: AssinPageControl!
    weak var adapter: InkPageControlAdapter?

    private lazy var behavior = InkCollectionViewScrollingBehavior(self, adapter: adapter)

    override func viewDidLoad() {
        super.viewDidLoad()
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        pageControl.numberOfPages = items.count
        pageControl.currentPageIndicatorTintColor = UIColor.black
        self.view.bringSubviewToFront(pageControl)
        self.collectionView.collectionViewLayout = flowLayout
        self.collectionView.register(ScrollingImageCell.self, forCellWithReuseIdentifier: ScrollingImageCell.swiftIdentifier)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 0
        flowLayout.itemSize = collectionView.bounds.size
        adapter = self
    }
}

extension UICollectionViewControllerExample: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ScrollingImageCell.swiftIdentifier, for: indexPath) as? ScrollingImageCell else {
            return UICollectionViewCell()
        }
        cell.imageSize = CGSize(width: 1280, height: 1080)
        cell.imageView.image = items[indexPath.row].image
        return cell
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.behavior.scrollViewWillBeginDragging(scrollView)
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.behavior.scrollViewDidEndDragging(scrollView, willDecelerate: decelerate)

    }
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        self.behavior.scrollViewWillEndDragging(scrollView, withVelocity: velocity, targetContentOffset: targetContentOffset)
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.behavior.scrollViewDidScroll(scrollView)
    }
}
extension UICollectionViewControllerExample: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
}

extension UICollectionViewControllerExample: InkPageCollectionViewBridge {
    var itemCount: Int {
        return items.count
    }

    var itemWidth: CGFloat {
        return flowLayout.itemSize.width
    }

    var contentOffset: CGPoint {
        return collectionView.contentOffset
    }

    func scrollToItem(page: Int) {
        let indexPath = IndexPath(item: page, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }

}

extension UICollectionViewControllerExample: InkPageControlAdapter {
    func pageControl(transitionCompleted page: Int) {
        self.pageControl?.endAnimation(page: page)
    }
    func pageControl(startPage: Int, endPage: Int) {
        self.pageControl?.beginAnimation(from: startPage, to: endPage)
    }
    func pageControl(progress: Double) {
        self.pageControl?.updateProgress(progress: progress)
    }
}
