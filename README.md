<p align="center">
   <img width="300" src="https://github.com/kimtaesu/Resources/blob/master/logo/v1/v1.png" alt="InkPageIndicator Logo">
</p>

<p align="center">
   <a href="https://developer.apple.com/swift/">
      <img src="https://img.shields.io/badge/Swift-5.0-orange.svg?style=flat" alt="Swift 5.0">
   </a>
   <a href="http://cocoapods.org/pods/InkPageIndicator">
      <img src="https://img.shields.io/cocoapods/v/InkPageIndicator.svg?style=flat" alt="Version">
   </a>
   <a href="http://cocoapods.org/pods/InkPageIndicator">
      <img src="https://img.shields.io/cocoapods/p/InkPageIndicator.svg?style=flat" alt="Platform">
   </a>
   <a href="https://github.com/Carthage/Carthage">
      <img src="https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat" alt="Carthage Compatible">
   </a>
</p>


InkPageIndicator is a beatuful UIPageControl

<img width="200" src="https://github.com/kimtaesu/Resources/blob/master/InkPageIndicator/demo.gif" alt="InkPageIndicator Logo">

## Requirements
* iOS 10.0+
* Xcode 10.2+
* Swift 5+

## Features

- [x] Supporting The [RxSwift](https://github.com/ReactiveX/RxSwift)
- [x] Timing issue for fast scrolling
- [x] To customize UIBeizerPath and LayoutArranger


## Installation

### CocoaPods

InkPageIndicator is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```bash
pod 'InkPageIndicator'
```

### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks.

To integrate InkPageIndicator into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
github "InkPageIndicator/InkPageIndicator"
```

Run `carthage update` to build the framework and drag the built `InkPageIndicator.framework` into your Xcode project. 

On your application targets’ “Build Phases” settings tab, click the “+” icon and choose “New Run Script Phase” and add the Framework path as mentioned in [Carthage Getting started Step 4, 5 and 6](https://github.com/Carthage/Carthage/blob/master/README.md#if-youre-building-for-ios-tvos-or-watchos)

### Manually

* Open up Terminal, `cd` into your top-level project directory, and run the following command
```
pod install --repo-update
open InkPageIndicator.xcworkspace
```
 

## Usage
<img width="400" src="https://github.com/kimtaesu/Resources/blob/master/InkPageIndicator/usage.png" alt="InkPageIndicator Logo">

```
pageControl.pageIndicatorTintColor = UIColor.lightGray
pageControl.numberOfPages = items.count
pageControl.currentPageIndicatorTintColor = UIColor.black
pageControl.currentPage = 1
pageControl.dotSize = CGSize(width: 8, height: 8)
pageControl.spacing = 20
```

### For UIPageViewController

##### YourUIViewController
Conform the `WrapInkPageControlAdapter` protocol
```
class YourUIViewController: UIViewController, WrapInkPageControlAdapter {
private lazy var pageContoller: AssinPageController = {
   return pageControl
}()
```

And set adapter to `YourUIPageViewController`
```
page.adapter = self
```

##### YourUIPageViewController

Enable swipe gesture and register delegate of scrollView,
To enable swipe gesture `YourUIPageViewController` conform `UIPageViewPageable`
```
class YourUIPageViewController: UIPageViewController, UIPageViewPageable

override func viewDidLoad() {
   super.viewDidLoad()
   self.enableSwipeGesture(self)
   self.scrollView?.delegate = self
}
```

Conform the `InkPagePageViewBridge` protocol 
```
extension YourUIPageViewController: InkPagePageViewBridge {
   func pageFirstIndex(viewControllers:) -> Int? {
    }
    
    var itemCount: Int {
    }
}
```

Conform the `UIPageViewControllerDelegate` protocol,
And call the function below codes
```
extension YourUIPageViewController: UIPageViewControllerDelegate {
    func pageViewController(_:willTransitionTo:) {
        self.behavior.pageViewController(pageViewController, willTransitionTo: pendingViewControllers)
    }
    func pageViewController(_: didFinishAnimating:previousViewControllers:transitionCompleted:) {
        self.behavior.pageViewController(
            pageViewController,
            didFinishAnimating: finished,
            previousViewControllers: previousViewControllers,
            transitionCompleted: completed
        )
    }
}
```

Declares a variable in your `YourUIPageViewController`
```
private lazy var behavior = InkPageViewScrollingBehavior(self, adapter: self)
```

Conform the `UIScrollViewDelegate` protocol
```
extension YourUIViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.behavior.scrollViewDidScroll(scrollView)
    }
}
```


### For UICollectionView

Conform the `WrapInkPageControlAdapter` protocol
```
class YourUIViewController: UIViewController, WrapInkPageControlAdapter {
private lazy var pageContoller: AssinPageController = {
   return pageControl
}()
```

Declares a variable in your 'UIViewController'
```
private lazy var behavior = InkCollectionViewScrollingBehavior(self, adapter: self)
```

Conform the `InkPageCollectionViewBridge` protocol
```
extension YourUIViewController: InkPageCollectionViewBridge {
    var itemCount: Int {
    }

    var itemWidth: CGFloat {
    }

    var contentOffset: CGPoint {
    }

    func scrollToItem(page: Int) {
    }
}
```

Conform the `UICollectionViewDelegateFlowLayout` protocol, 
And call the function below codes
```
extension UICollectionViewControllerExample: UICollectionViewDataSource {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.behavior.scrollViewWillBeginDragging(scrollView)
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.behavior.scrollViewDidEndDragging(scrollView, willDecelerate: decelerate)

    }
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        self.behavior.scrollViewWillEndDragging(scrollView, withVelocity: velocity, targetContentOffset: targetContentOffset)
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.behavior.scrollViewDidScroll(scrollView)
    }
}
```

## Contributing
Contributions are very welcome 🙌

## License
InkPageIndicator is released under the MIT license. See LICENSE for details.
