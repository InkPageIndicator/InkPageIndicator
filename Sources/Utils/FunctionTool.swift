//
//  FunctionTool.swift
//  InkPageIndicator-iOS
//
//  Created by tskim on 12/09/2019.
//  Copyright © 2019 Tyler. All rights reserved.
//

import Foundation

func conditionError(_ error: Error) {
    #if DEBUG
        if !isTest() {
            fatalError(error.localizedDescription)
        }
    #endif
    print("\(error): \(error.localizedDescription)")
}

func isTest() -> Bool {
    return NSClassFromString("XCTestCase") != nil
}
