// swift-tools-version:4.0

import PackageDescription

let package = Package(
  name: "Commander",
  dependencies: [
    .package(url: "https://github.com/kylef/Spectre.git", from: "0.8.0"),
  ],
  targets: [
    .target(name: "Commander", dependencies: []),
    .testTarget(name: "CommanderTests", dependencies: ["Commander", "Spectre"]),
  ]
)
