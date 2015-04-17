![Twinkle](https://raw.github.com/piemonte/twinkle/master/twinkle.gif)

## Twinkle :sparkles:

`Twinkle` is a [Swift](https://developer.apple.com/swift/) and easy way to make any UIView in your iOS app twinkle.

This library creates several CAEmitterLayers and animates them generating a sparkle effect.

[![Pod Version](https://img.shields.io/cocoapods/v/Twinkle.svg?style=flat)](http://cocoadocs.org/docsets/Twinkle/)

## Installation

### CocoaPods

`Twinkle` is available and recommended for installation using the Cocoa dependency manager [CocoaPods](http://cocoapods.org/). Swift is supported as of version 0.36.

To integrate, add the following to your `Podfile`:

```ruby
source ‘https://github.com/CocoaPods/Specs.git'
platform :iOS, ‘8.0’
use_frameworks!

pod ‘Twinkle’
```	

### Carthage

Installation is also available using the dependency manager [Carthage](https://github.com/Carthage/Carthage).

To integrate, add the following line to your `Cartfile`:

```ogdl
github “piemonte/Twinkle” >= 0.0.2
```

### Manual

You can also simply copy the `Twinkle.swift` file into your Xcode project.

## Usage

The sample project provides an example of how to integrate `Twinkle`, otherwise you can follow this example.

``` Swift
   import Twinkle
```

``` Swift
   let view: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 150, height: 50))
   self.view.addSubview(view)
   view.twinkle()
```

## Community

- Found a bug? Open an [issue](https://github.com/piemonte/twinkle/issues).
- Feature idea? Open an [issue](https://github.com/piemonte/twinkle/issues).
- Want to contribute? Submit a [pull request](https://github.com/piemonte/twinkle/pulls).

## Resources

* [Core Animation Reference Collection](https://developer.apple.com/library/ios/documentation/Cocoa/Reference/CoreAnimation_framework/index.html)
* [Shimmer](https://github.com/facebook/shimmer)
* [objc.io Issue #16, Swift](http://www.objc.io/issue-16/)

## License

Twinkle is available under the MIT license, see the [LICENSE](https://github.com/piemonte/twinkle/blob/master/LICENSE) file for more information.
