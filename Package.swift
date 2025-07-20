// swift-tools-version:5.9

import PackageDescription

let package = Package(
    name: "Twinkle",
    platforms: [
      .iOS(.v15),
      .tvOS(.v15)
    ],
    products: [
      .library(name: "Twinkle", targets: ["Twinkle"])
    ],
    targets: [
      .target(
          name: "Twinkle",
          path: "Sources",
          resources: [
              .process("Resources")
          ]
      )
    ],
    swiftLanguageVersions: [.v5]
)
