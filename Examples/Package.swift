// swift-tools-version:4.0

import PackageDescription

let package = Package(
  name: "CommanderExamples",
  products: [
    .executable(name: "generator", targets: ["generator"]),
    .executable(name: "sleep", targets: ["sleep"]),
  ],
  dependencies: [
    .package(url: "../", .branch("async")),
    .package(url: "https://github.com/stencilproject/Stencil.git", from: "0.12.0"),
  ],
  targets: [
    .target(
      name: "generator",
      dependencies: ["Commander", "Stencil"],
      exclude: [
        "template.swift",
      ]
    ),

    .target(
      name: "sleep",
      dependencies: ["Commander"]
    ),
  ]
)
