<p align="center">
   <img width="300" src="https://github.com/kimtaesu/Resources/blob/master/Icon/icon.png" alt="InkPageIndicator Logo">
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
   <a href="https://github.com/apple/swift-package-manager">
      <img src="https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg" alt="SPM">
   </a>
</p>


InkPageIndicator is a beatuful UIPageControl

<img width="200" src="/Documents/Demo.gif" alt="InkPageIndicator Logo">


## Features

- [x] Supporting The [RxSwift](https://github.com/ReactiveX/RxSwift)
- [x] Timing issue for fast scrolling


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
github "Tyler/InkPageIndicator"
```

Run `carthage update` to build the framework and drag the built `InkPageIndicator.framework` into your Xcode project. 

On your application targets’ “Build Phases” settings tab, click the “+” icon and choose “New Run Script Phase” and add the Framework path as mentioned in [Carthage Getting started Step 4, 5 and 6](https://github.com/Carthage/Carthage/blob/master/README.md#if-youre-building-for-ios-tvos-or-watchos)

### Swift Package Manager

To integrate using Apple's [Swift Package Manager](https://swift.org/package-manager/), add the following as a dependency to your `Package.swift`:

```swift
dependencies: [
    .package(url: "git@github.com:kimtaesu/InkPageIndicator.git.git", from: "1.0.0")
]
```

### Manually

If you prefer not to use any of the aforementioned dependency managers, you can integrate InkPageIndicator into your project manually. Simply drag the `Sources` Folder into your Xcode project.

## Usage

ℹ️ Describe the usage of your Kit

## Contributing
Contributions are very welcome 🙌

## License
InkPageIndicator is released under the MIT license. See LICENSE for details.
