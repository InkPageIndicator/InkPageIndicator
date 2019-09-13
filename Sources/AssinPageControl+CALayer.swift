//
//  AssinPageControl+CALayer.swift
//  InkPageIndicator-iOS
//
//  Created by tskim on 12/09/2019.
//  Copyright © 2019 Tyler. All rights reserved.
//

import UIKit

extension CALayer {
    func findSubLayersByKey(key: String) -> [CALayer] {
        return self.sublayers?.filter {
            $0.name == key
            } ?? []
    }
}
