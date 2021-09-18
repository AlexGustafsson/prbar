// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "prbar",
  platforms: [.macOS(.v11)],
  products: [
    .executable(
      name: "prbar",
      targets: ["prbar"]
    ),
  ],
  dependencies: [
      .package(url: "https://github.com/apple/swift-argument-parser", .upToNextMinor(from: "1.0.0")),
  ],
  targets: [
   .target(
      name: "prbar",
      dependencies: [
          .product(name: "ArgumentParser", package: "swift-argument-parser"),
      ]
    ),
  ]
)
