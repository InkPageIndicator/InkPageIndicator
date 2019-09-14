//
//  BoundAllocator.swift
//  InkPageIndicator-iOS
//
//  Created by tskim on 12/09/2019.
//  Copyright © 2019 Tyler. All rights reserved.
//

import UIKit

public class CenterLayoutArranger {
    func arrange(viewSize: CGRect, childSizes: [CGSize], interval: CGFloat) -> [CGRect] {
        let location = calculateStartEndPoint(viewSize: viewSize, childSizes: childSizes, interval: interval)

        var contentWidth = location.origin.x

        var childRect: [CGRect] = []

        for size in childSizes {
            if location.size == .zero ||  viewSize.height <= 0 {
                childRect.append(.zero)
                continue
            }
            let centerY = (viewSize.height / 2) - (size.height / 2)
            let size = CGSize(width: size.width, height: min(viewSize.height, size.height))
            let origin = CGPoint(x: contentWidth, y: max(centerY, 0))
            childRect.append(CGRect(origin: origin, size: size))
            contentWidth += size.width
            contentWidth += CGFloat(interval)
        }
        return childRect
    }

    internal func calculateStartEndPoint(viewSize: CGRect, childSizes: [CGSize], interval: CGFloat) -> CGRect {
        let halfCenterX = viewSize.width / 2
        if halfCenterX <= 0 {
            conditionError(AssinError.zeroSize)
            return .zero
        }
        let spacing: CGFloat = interval * CGFloat(childSizes.count - 1)
        let halfRowWidth = (childSizes.rowWidth + spacing) / 2

        if halfCenterX < halfRowWidth {
            conditionError(AssinError.excessSize)
            return .zero
        }

        let startX = halfCenterX - halfRowWidth

        return CGRect(x: startX, y: 0, width: childSizes.rowWidth + spacing, height: 0)
    }
}
