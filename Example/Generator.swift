//
//  Generator.swift
//  Example
//
//  Created by tskim on 13/09/2019.
//  Copyright © 2019 Tyler. All rights reserved.
//

import UIKit

 func generateViewController(_ model: ChildModel) -> UIViewController {
    let vc = ChildViewController()
    vc.model = model
    return vc
}
