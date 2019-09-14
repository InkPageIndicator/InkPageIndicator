//
//  StoryboardInitializable.swift
//  Example
//
//  Created by tskim on 14/09/2019.
//  Copyright © 2019 Tyler. All rights reserved.
//

import UIKit

protocol StoryboardInitializable {
  static var storyboardIdentifier: String { get }
}

extension StoryboardInitializable where Self: UIViewController {
  
  static var storyboardIdentifier: String {
    return String(describing: Self.self)
  }
  
  static func initFromStoryboard(name: String = "Main") -> Self {
    let storyboard = UIStoryboard(name: name, bundle: Bundle.main)
    // swiftlint:disable:next force_cast
    return storyboard.instantiateViewController(withIdentifier: storyboardIdentifier) as! Self
  }
}
