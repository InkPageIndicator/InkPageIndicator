//
//  UICollectionViewExample.swift
//  Example
//
//  Created by tskim on 13/09/2019.
//  Copyright © 2019 Tyler. All rights reserved.
//

import UIKit
import InkPageIndicator

enum ScrollDirection {
    case left
    case right
}
class UICollectionViewControllerExample: UIViewController {

    lazy var flowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        return flowLayout
    }()

    @IBOutlet weak var collectionView: UICollectionView!

    private var items = ChildModel.dummy

    @IBOutlet weak var pageControl: AssinPageControl!
    private var currentItem: Int = 0
    private var direction: ScrollDirection = .left
    
    private var indexOfCellBeforeDragging = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        pageControl.numberOfPages = items.count
        pageControl.currentPageIndicatorTintColor = UIColor.black
        self.view.bringSubviewToFront(pageControl)
        self.collectionView.collectionViewLayout = flowLayout
        self.collectionView.register(ScrollingImageCell.self, forCellWithReuseIdentifier: ScrollingImageCell.swiftIdentifier)
        self.collectionView.delegate = self
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 0
        flowLayout.itemSize = collectionView.bounds.size
        self.collectionView.dataSource = self
    }
}

extension UICollectionViewControllerExample: UISearchControllerDelegate {

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


}
extension UICollectionViewControllerExample: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
}

extension UICollectionViewControllerExample: UIGestureRecognizerDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        // Stop scrollView sliding:
        targetContentOffset.pointee = scrollView.contentOffset
        
        // calculate where scrollView should snap to:
        let indexOfMajorCell = self.indexOfMajorCell()
        
        // calculate conditions:
        let swipeVelocityThreshold: CGFloat = 0.5 // after some trail and error
        let hasEnoughVelocityToSlideToTheNextCell = indexOfCellBeforeDragging + 1 < items.count && velocity.x > swipeVelocityThreshold
        let hasEnoughVelocityToSlideToThePreviousCell = indexOfCellBeforeDragging - 1 >= 0 && velocity.x < -swipeVelocityThreshold
        let majorCellIsTheCellBeforeDragging = indexOfMajorCell == indexOfCellBeforeDragging
        let didUseSwipeToSkipCell = majorCellIsTheCellBeforeDragging && (hasEnoughVelocityToSlideToTheNextCell || hasEnoughVelocityToSlideToThePreviousCell)
        
        if didUseSwipeToSkipCell {
            let snapToIndex = indexOfCellBeforeDragging + (hasEnoughVelocityToSlideToTheNextCell ? 1 : -1)
            let toValue = flowLayout.itemSize.width * CGFloat(snapToIndex)
            
            // Damping equal 1 => no oscillations => decay animation:
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: velocity.x, options: .allowUserInteraction, animations: {
                scrollView.contentOffset = CGPoint(x: toValue, y: 0)
                scrollView.layoutIfNeeded()
            }, completion: nil)
            currentItem = snapToIndex
            
        } else {
            // This is a much better way to scroll to a cell:
            let indexPath = IndexPath(row: indexOfMajorCell, section: 0)
            flowLayout.collectionView!.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            currentItem = indexOfMajorCell
        }
        self.pageControl.currentPage = currentItem
         self.pageControl.cancelAnimation()
    }

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        indexOfCellBeforeDragging = indexOfMajorCell()
        let translation = scrollView.panGestureRecognizer.translation(in: scrollView.superview)
        
        var nextItem = currentItem
        if translation.x >= 0 {
            // left
            direction = .left
            nextItem = max(currentItem - 1, 0)
        } else {
            // right
            direction = .right
            nextItem = min(currentItem + 1, items.count - 1)
        }
        
        self.pageControl.beginAnimation(from: currentItem, to: nextItem)
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let numberOfPages = items.count
        let total = scrollView.contentSize.width - scrollView.bounds.width
        let offset = scrollView.contentOffset.x
        let percent = Double(offset / total)

        let progress = percent * Double(numberOfPages - 1)

        var newProgress = progress.truncatingRemainder(dividingBy: 1)
        
        switch direction {
        case .left:
            newProgress = abs(1 - newProgress)
        case .right:
            break
        }

        self.pageControl(progress: newProgress)
    }
    private func indexOfMajorCell() -> Int {
        let itemWidth = flowLayout.itemSize.width
        let proportionalOffset = collectionView.contentOffset.x / itemWidth
        let index = Int(round(proportionalOffset))
        let safeIndex = max(0, min(items.count - 1, index))
        return safeIndex
    }
}
extension UICollectionViewControllerExample: UIPageContarolDelegate {
    func pageControl(completePage: Int) {
        self.pageControl.currentPage = completePage
    }
    func pageControl(finished: Bool) {
        self.pageControl?.endAnimation()
    }
    func pageControl(startPage: Int, endPage: Int) {
        self.pageControl?.beginAnimation(from: startPage, to: endPage)
    }
    func pageControl(progress: Double) {
        self.pageControl?.updateProgress(progress: progress)
    }
}
