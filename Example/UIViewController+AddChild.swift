//
//  UIViewController.swift
//  Example
//
//  Created by tskim on 12/09/2019.
//  Copyright © 2019 Tyler. All rights reserved.
//

import UIKit

extension UIViewController {
    func removeViewController(_ target: UIViewController) {
        target.willMove(toParent: nil)
        target.removeFromParent()
        target.view.removeFromSuperview()
        target.didMove(toParent: nil)
    }
    
    func addSubViewController(_ target: UIViewController) {
        target.willMove(toParent: self)
        self.addChild(target)
        view.addSubview(target.view)
        target.didMove(toParent: self)
    }
}
