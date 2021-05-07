// swift-tools-version:4.0

import PackageDescription

let package = Package(
  name: "Commander",
  products: [
    .library(name: "Commander", targets: ["Commander"]),
  ],
  dependencies: [
    .package(url: "https://github.com/kylef/Spectre.git", .revision("69da3ff"))
  ],
  targets: [
    .target(name: "Commander", dependencies: []),
    .testTarget(name: "CommanderTests", dependencies: ["Commander", "Spectre"]),
  ]
)
