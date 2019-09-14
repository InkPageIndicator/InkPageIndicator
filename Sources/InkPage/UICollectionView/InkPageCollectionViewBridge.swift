//
//  InkPageCollectionViewBridge.swift
//  InkPageIndicator
//
//  Created by tskim on 15/09/2019.
//  Copyright © 2019 Tyler. All rights reserved.
//

import UIKit

public protocol InkPageCollectionViewBridge: class {
    var itemCount: Int { get }
    var itemWidth: CGFloat { get }
    var contentOffset: CGPoint { get }
    func scrollToItem(page: Int)
}
