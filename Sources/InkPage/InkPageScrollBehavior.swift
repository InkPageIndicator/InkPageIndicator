//
//  InkPageScrollBehavior.swift
//  InkPageIndicator
//
//  Created by tskim on 15/09/2019.
//  Copyright © 2019 Tyler. All rights reserved.
//

import UIKit

public final class InkPageScrollBehavior: NSObject {
    private var indexOfCellBeforeDragging = 0
    private var lastContentOffset: CGPoint = .zero
    private var isAnimating: Bool = false
    private var isBegenDragging: Bool = false
    private var currentPage: Int = 0
    private var adapter: InkPageControlAdapter?
    private unowned let bridge: InkPageCollectionViewBridge

    public init(_ bridge: InkPageCollectionViewBridge, adapter: InkPageControlAdapter?) {
        self.bridge = bridge
        self.adapter = adapter
    }

    public func scrollViewWillEndDragging(
        _ scrollView: UIScrollView,
        withVelocity velocity: CGPoint,
        targetContentOffset: UnsafeMutablePointer<CGPoint>
    ) {
        // Stop scrollView sliding:
        targetContentOffset.pointee = scrollView.contentOffset

        // calculate where scrollView should snap to:
        let indexOfMajorCell = self.indexOfMajorCell()

        // calculate conditions:
        let swipeVelocityThreshold: CGFloat = 0.5 // after some trail and error
        let hasEnoughVelocityToSlideToTheNextCell =
            indexOfCellBeforeDragging + 1 < Int(bridge.itemWidth) && velocity.x > swipeVelocityThreshold
        let hasEnoughVelocityToSlideToThePreviousCell =
            indexOfCellBeforeDragging - 1 >= 0 && velocity.x < -swipeVelocityThreshold
        let majorCellIsTheCellBeforeDragging = indexOfMajorCell == indexOfCellBeforeDragging
        let didUseSwipeToSkipCell =
            majorCellIsTheCellBeforeDragging &&
                (hasEnoughVelocityToSlideToTheNextCell || hasEnoughVelocityToSlideToThePreviousCell)

        if didUseSwipeToSkipCell {
            let snapToIndex = indexOfCellBeforeDragging + (hasEnoughVelocityToSlideToTheNextCell ? 1 : -1)
            let toValue = bridge.itemWidth * CGFloat(snapToIndex)

            // Damping equal 1 => no oscillations => decay animation:
            UIView.animate(
                withDuration: 0.3,
                delay: 0,
                usingSpringWithDamping: 1,
                initialSpringVelocity: velocity.x,
                options: .allowUserInteraction,
                animations: {
                    scrollView.contentOffset = CGPoint(x: toValue, y: 0)
                    scrollView.layoutIfNeeded()
                }, completion: nil)
            currentPage = snapToIndex
        } else {
            // This is a much better way to scroll to a cell:
            self.bridge.scrollToItem(page: indexOfMajorCell)
//            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            currentPage = indexOfMajorCell
        }
        adapter?.pageControl(transitionCompleted: currentPage)
    }

    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.isAnimating = false
        self.isBegenDragging = false
    }
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isBegenDragging = true
        indexOfCellBeforeDragging = indexOfMajorCell()
        lastContentOffset = scrollView.contentOffset
    }
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let itemCount = bridge.itemCount
        var nextItem = currentPage
        if isBegenDragging && !isAnimating {
            if lastContentOffset.x > scrollView.contentOffset.x {
                // left
                nextItem = max(currentPage - 1, 0)
            } else {
                // right
                nextItem = min(currentPage + 1, itemCount - 1)
            }
            adapter?.pageControl(startPage: currentPage, endPage: nextItem)
            isAnimating = true
        }
        if isAnimating {
            let total = scrollView.contentSize.width - scrollView.bounds.width
            let offset = scrollView.contentOffset.x
            let percent = Double(offset / total)

            let progress = percent * Double(itemCount - 1)

            var newProgress = progress.truncatingRemainder(dividingBy: 1)

            if lastContentOffset.x > scrollView.contentOffset.x {
                newProgress = abs(1 - newProgress)
            }
            adapter?.pageControl(progress: newProgress)
        }
    }
    private func indexOfMajorCell() -> Int {
        let proportionalOffset = bridge.contentOffset.x / bridge.itemWidth
        let index = Int(round(proportionalOffset))
        let safeIndex = max(0, min(bridge.itemCount - 1, index))
        return safeIndex
    }
}
