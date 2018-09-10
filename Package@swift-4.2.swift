// swift-tools-version:4.2

import PackageDescription

let package = Package(
  name: "Commander",
  products: [
    .library(name: "Commander", targets: ["Commander"]),
  ],
  dependencies: [
    .package(url: "https://github.com/kylef/Spectre.git", from: "0.8.0"),
  ],
  targets: [
    .target(name: "Commander", dependencies: []),
    .testTarget(name: "CommanderTests", dependencies: ["Commander", "Spectre"]),
  ],
  swiftLanguageVersions: [.v4, .v4_2]
)
