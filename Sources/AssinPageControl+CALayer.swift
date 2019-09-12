//
//  AssinPageControl+CALayer.swift
//  InkPageIndicator-iOS
//
//  Created by tskim on 12/09/2019.
//  Copyright © 2019 Tyler. All rights reserved.
//

import UIKit

private extension CALayer {
    func findLayerByKey(key: String) -> [CALayer] {
        return self.sublayers?.filter {
            $0.name == key
            } ?? []
    }
}
