//
//  InkPagePageViewBridge.swift
//  InkPageIndicator
//
//  Created by tskim on 15/09/2019.
//  Copyright © 2019 Tyler. All rights reserved.
//

import UIKit

public protocol InkPagePageViewBridge: class {
    var itemCount: Int { get }
    func pageFirstIndex(viewControllers: [UIViewController]) -> Int?
}
