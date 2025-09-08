# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Twinkle is a Swift library that creates sparkle/twinkle animations for UIViews in iOS and tvOS applications. It uses CAEmitterLayers to generate the sparkle effect.

## Architecture

The library consists of a single main source file at `Sources/Twinkle.swift` that contains:
- `Twinkle` enum: Main public API with static methods and Configuration struct
- `TwinkleLayer`: Internal CAEmitterLayer subclass that handles the actual animation
- UIView extension: Convenience method for adding twinkle effect to any view
- Bundle extension: Resource loading support for Swift Package Manager

Resource image located at `Sources/Resources/TwinkleImage.png`

## Build Commands

### Xcode Project Build
```bash
# Build for iOS (Debug)
xcodebuild -project Twinkle/Twinkle.xcodeproj -scheme 'Debug - iOS' -sdk iphonesimulator build

# Build for tvOS (Debug)
xcodebuild -project Twinkle/Twinkle.xcodeproj -scheme 'Debug - tvOS' -sdk appletvsimulator build

# Build for iOS (Release)
xcodebuild -project Twinkle/Twinkle.xcodeproj -scheme 'Release - iOS' -sdk iphonesimulator build

# Build for tvOS (Release)
xcodebuild -project Twinkle/Twinkle.xcodeproj -scheme 'Release - tvOS' -sdk appletvsimulator build
```

### Swift Package Manager Build
```bash
swift build
```

## Platform Requirements

- iOS 15.0+ / tvOS 15.0+
- Xcode 15.0+
- Swift 5.9+

## Distribution Formats

The library supports three package managers:
- **CocoaPods**: Via `Twinkle.podspec`
- **Carthage**: Direct GitHub integration
- **Swift Package Manager**: Via `Package.swift`