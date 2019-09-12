//
//  Array+Row.swift
//  InkPageIndicator-iOS
//
//  Created by tskim on 12/09/2019.
//  Copyright © 2019 Tyler. All rights reserved.
//

import UIKit

internal extension Array where Element == CGSize {
    
    var rowWidth: CGFloat {
        return self.reduce(0) { acc, size in acc + size.width }
    }
}
