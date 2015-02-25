## Twinkle

`Twinkle` is a [Swift](https://developer.apple.com/swift/) and easy way to make any UIView in your iOS app twinkle.

This library creates several `CAEmitterLayer` elements and animates them over a few creating a sparkle effect.

## Installation

### CocoaPods

`Twinkle` is available and recommended for installation using the Cocoa dependency manager [CocoaPods](http://cocoapods.org/). CocoaPods is still adding support for Swift, so a [pre-release](http://blog.cocoapods.org/Pod-Authors-Guide-to-CocoaPods-Frameworks/) version is required.

To integrate, just add the following line in your `Podfile`:

```ruby
pod ‘Twinkle’
```	

### Carthage

Installation is also available using the dependency manager [Carthage](https://github.com/Carthage/Carthage).

To integrate, add the following line to your `Cartfile`:

```ogdl
github “piemonte/Twinkle” >= 0.0.1
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

* [Shimmer](https://github.com/facebook/shimmer)
* [objc.io Issue #16, Swift](http://www.objc.io/issue-16/)

## License

Twinkle is available under the MIT license, see the [LICENSE](https://github.com/piemonte/twinkle/blob/master/LICENSE) file for more information.
