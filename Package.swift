// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "Twinkle",
    platforms: [
      .iOS(.v10),
      .tvOS(.v10)
    ],
    products: [
      .library(name: "Twinkle", targets: ["Twinkle"])
    ],
    targets: [
      .target(
          name: "Twinkle",
          path: "Sources"
      )
    ],
    swiftLanguageVersions: [.v5]
)
