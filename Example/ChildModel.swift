//
//  ChildModel.swift
//  Example
//
//  Created by tskim on 13/09/2019.
//  Copyright © 2019 Tyler. All rights reserved.
//

import UIKit

struct ChildModel {
    let image: UIImage
}


extension ChildModel {
    static var dummy: [ChildModel] {
        return [
            ChildModel(image: #imageLiteral(resourceName: "girl")),
            ChildModel(image: #imageLiteral(resourceName: "banff")),
            ChildModel(image: #imageLiteral(resourceName: "asia"))
        ]
    }
}
