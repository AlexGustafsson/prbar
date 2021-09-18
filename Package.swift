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
      .package(name: "OctoKit", url: "https://github.com/nerdishbynature/octokit.swift", from: "0.11.0"),
      .package(url: "https://github.com/kishikawakatsumi/KeychainAccess", from: "4.2.2"),
  ],
  targets: [
   .target(
      name: "prbar",
      dependencies: [
          .product(name: "ArgumentParser", package: "swift-argument-parser"),
          .product(name: "OctoKit", package: "OctoKit"),
          .product(name: "KeychainAccess", package: "KeychainAccess"),
      ],
      linkerSettings: [
        .unsafeFlags([
          "-Xlinker", "-sectcreate", "-Xlinker", "__TEXT", "-Xlinker", "__info_plist", "-Xlinker",
          "./SupportingFiles/prbar/Info.plist",
        ]),
      ]
    ),
  ]
)
