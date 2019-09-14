//
//  InitRx.swift
//  Example
//
//  Created by tskim on 14/09/2019.
//  Copyright © 2019 Tyler. All rights reserved.
//

import Foundation
import InkPageIndicator
import RxCocoa
import RxSwift

public typealias PageControlBeginParameter = (Int, Int)

public extension Reactive where Base: AssinPageController {
    var progress: Binder<Double> {
        return Binder(self.base) { pager, progress in
            pager.updateProgress(progress: progress)
        }
    }
    var beginAnimation: Binder<PageControlBeginParameter> {
        return Binder(self.base) { pager, pages in
            pager.beginAnimation(from: pages.0, to: pages.1)
        }
    }
    var endAnimation: Binder<Int> {
        return Binder(self.base) { pager, completePage in
            pager.endAnimation(page: completePage)
        }
    }
}
