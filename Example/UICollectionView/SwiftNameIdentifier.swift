//
//  SwiftNameIdentifier.swift
//  Example
//
//  Created by tskim on 13/09/2019.
//  Copyright © 2019 Tyler. All rights reserved.
//

import Foundation

protocol SwiftNameIdentifier {
    static var swiftIdentifier: String { get }
}
extension SwiftNameIdentifier {
    static var swiftIdentifier: String {
        return String(describing: Self.self)
    }
}
