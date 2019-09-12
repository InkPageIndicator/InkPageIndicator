//
//  Array+Subscript.swift
//  InkPageIndicator-iOS
//
//  Created by tskim on 12/09/2019.
//  Copyright © 2019 Tyler. All rights reserved.
//

import Foundation

extension Array {
    subscript (safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
}
