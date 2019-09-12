//
//  CenterFitArranger.swift
//  InkPageIndicator-iOS
//
//  Created by tskim on 12/09/2019.
//  Copyright © 2019 Tyler. All rights reserved.
//

@testable import InkPageIndicator
import XCTest
import UIKit

class CenterLayoutArrangerTest: XCTestCase {

    static var allTests = [
        ("testCenterStartPoint", testCenterStartPoint),
        ("testZeroHeightCenterArarange", testZeroHeightCenterArarange),
        ("testZeroWidthCenterArarange", testZeroWidthCenterArarange),
        ("testCenterArarange", testCenterArarange)
    ]

    var arranger: CenterLayoutArranger!

    let viewSize = CGRect(x: 0, y: 0, width: 414, height: 50)

    let childSizes = [
        CGSize(width: 20, height: 20),
        CGSize(width: 20, height: 20),
        CGSize(width: 20, height: 20)
    ]
    
    override func setUp() {
        super.setUp()
        arranger = CenterLayoutArranger()
    }
    func testCenterStartPoint() {
        let actual = arranger.calculateStartEndPoint(viewSize: viewSize, childSizes: childSizes, interval: 20)
        /*
         |------<xxx|xxx>-----|
         */
        XCTAssertEqual(actual, CGRect(x: 157.0, y: 0, width: 100, height: 0))
    }

    func testZeroHeightCenterArarange() {
        
        let viewSize = CGRect(x: 0, y: 0, width: 414, height: 0)
        let actual = arranger.arrange(viewSize: viewSize, childSizes: childSizes, interval: 20)
        let expect = [
            CGRect(x: 0, y: 0.0, width: 0, height: 0.0),
            CGRect(x: 0, y: 0.0, width: 0, height: 0.0),
            CGRect(x: 0, y: 0.0, width: 0, height: 0.0)
        ]
        XCTAssertEqual(actual, expect)
    }
    
    func testZeroWidthCenterArarange() {
        
        let viewSize = CGRect(x: 0, y: 0, width: 0, height: 50)
        let actual = arranger.arrange(viewSize: viewSize, childSizes: childSizes, interval: 20)
        let expect = [
            CGRect(x: 0, y: 0, width: 0, height: 0),
            CGRect(x: 0, y: 0, width: 0, height: 0),
            CGRect(x: 0, y: 0, width: 0, height: 0)
        ]
        XCTAssertEqual(actual, expect)
    }
    func testCenterArarange() {
        let actual = arranger.arrange(viewSize: viewSize, childSizes: childSizes, interval: 20)

        /*
         |--------------------|
         |------o---o---o-----|
         |--------------------|
         */
        let expect = [
            CGRect(x: 157, y: 15.0, width: 20, height: 20),
            CGRect(x: 197, y: 15.0, width: 20, height: 20),
            CGRect(x: 237, y: 15.0, width: 20, height: 20)
        ]
        XCTAssertEqual(actual, expect)
    }

}
