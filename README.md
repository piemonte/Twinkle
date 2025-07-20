![Twinkle](https://raw.github.com/piemonte/twinkle/master/twinkle.gif)

## Twinkle :sparkles:

`Twinkle` is a [Swift](https://developer.apple.com/swift/) and easy way to make any UIView in your iOS or tvOS app twinkle.

This library creates several CAEmitterLayers and animates them generating a sparkle effect.

A version of Twinkle is also [available for Android](https://github.com/dev-labs-bg/twinkle).

If you like Twinkle, you may also like [Burst](https://github.com/piemonte/Burst).

[![Build Status](https://travis-ci.com/piemonte/Twinkle.svg?branch=master)](https://travis-ci.com/piemonte/Twinkle) [![Pod Version](https://img.shields.io/cocoapods/v/Twinkle.svg?style=flat)](http://cocoadocs.org/docsets/Twinkle/) [![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage) [![Swift Version](https://img.shields.io/badge/language-swift%205.9-brightgreen.svg)](https://developer.apple.com/swift) [![GitHub license](https://img.shields.io/badge/license-MIT-lightgrey.svg)](https://github.com/piemonte/Twinkle/blob/master/LICENSE)

## Requirements

* iOS 15.0+ / tvOS 15.0+
* Xcode 15.0+
* Swift 5.9+

# Quick Start

`Twinkle` is available and recommended for installation using the Cocoa dependency manager [CocoaPods](http://cocoapods.org/). You can also simply copy the `Twinkle.swift` file into your Xcode project.

```ruby
# CocoaPods
pod "Twinkle", "~> 0.6.0"

# Carthage
github "piemonte/Twinkle" ~> 0.6.0

# SwiftPM
let package = Package(
    dependencies: [
        .package(url: "https://github.com/piemonte/Twinkle", from: "0.6.0")
    ]
)
```

## Usage

The sample project provides an example of how to integrate `Twinkle`, otherwise you can follow this example.

``` Swift
   import Twinkle
```

``` Swift

   // using the UIView extension
   let view: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 150, height: 50))
   self.view.addSubview(view)
   view.twinkle()

   // using the class func
   Twinkle.twinkle(myView)
```

## Community

- Found a bug? Open an [issue](https://github.com/piemonte/twinkle/issues).
- Feature idea? Open an [issue](https://github.com/piemonte/twinkle/issues).
- Want to contribute? Submit a [pull request](https://github.com/piemonte/twinkle/pulls).

## Resources

* [Core Animation Reference Collection](https://developer.apple.com/library/ios/documentation/Cocoa/Reference/CoreAnimation_framework/index.html)
* [Swift Evolution](https://github.com/apple/swift-evolution)
* [CAEmitterLayer – NSHipster](https://nshipster.com/caemitterlayer/)
* [Twinkle for Android](https://github.com/dev-labs-bg/twinkle)
* [Burst](https://github.com/piemonte/Burst)
* [Shimmer](https://github.com/facebook/shimmer)
* [Blurry](https://github.com/piemonte/Blurry)

## License

Twinkle is available under the MIT license, see the [LICENSE](https://github.com/piemonte/twinkle/blob/master/LICENSE) file for more information.
