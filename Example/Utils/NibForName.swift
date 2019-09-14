//
//  NibName.swift
//  Example
//
//  Created by tskim on 14/09/2019.
//  Copyright © 2019 Tyler. All rights reserved.
//

import Foundation
import UIKit

protocol NibForName: SwiftNameIdentifier {
  static var nib: UINib { get }
}
extension NibForName {
  static var nib: UINib {
    return UINib(nibName: String(describing: Self.self), bundle: nil)
  }
}
