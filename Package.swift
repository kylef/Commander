// swift-tools-version:5.5

import PackageDescription

let package = Package(
  name: "Commander",
  products: [
    .library(name: "Commander", targets: ["Commander"]),
  ],
  dependencies: [
    .package(url: "https://github.com/kylef/Spectre.git", from: "0.10.0"),
  ],
  targets: [
    .target(name: "Commander", dependencies: []),
    .testTarget(name: "CommanderTests", dependencies: ["Commander", "Spectre"]),
  ]
)
