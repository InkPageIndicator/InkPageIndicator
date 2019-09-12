//
//  InkPageBeizerPathProvider.swift
//  InkPageIndicator-iOS
//
//  Created by tskim on 13/09/2019.
//  Copyright © 2019 Tyler. All rights reserved.
//

@testable import InkPageIndicator
import XCTest
import UIKit

class UIBeizerPathProviderTest: XCTestCase {

    static var allTests = [
        ("testSimpleBeizerPath", testSimpleBeizerPath),
    ]
    let viewSize = CGRect(x: 173, y: 11, width: 16, height: 16)
    let childSizes = [
        CGSize(width: 20, height: 20),
        CGSize(width: 20, height: 20),
        CGSize(width: 20, height: 20)
    ]

    func testSimpleBeizerPath() {
//        <MoveTo {0, 0}>,
//        <LineTo {0, 16}>,
//        <CurveTo {25, 8} {0, 16} {25, 16}>,
//        <CurveTo {0, 0} {25, 0} {0, 0}>,
//        <Close>")
        let expect = UIBezierPath()
        expect.move(to: .zero)
        expect.addLine(to: CGPoint(x: 0, y: 16))
        expect.addCurve(to: CGPoint(x: 25, y: 8), controlPoint1: CGPoint(x: 0, y: 16), controlPoint2: CGPoint(x: 25, y: 16))
        expect.addCurve(to: CGPoint(x: 0, y: 0), controlPoint1: CGPoint(x: 25, y: 0), controlPoint2: CGPoint(x: 0, y: 0))
        expect.close()
        let actual = UIBeizerPathProvider.instance.inkPage(frame: viewSize, controlX: 25, spacing: 20)
        XCTAssertEqual(expect, actual)
    }
}

