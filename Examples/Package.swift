// swift-tools-version:4.0

import PackageDescription

let package = Package(
  name: "CommanderExamples",
  products: [
    .executable(name: "generator", targets: ["generator"]),
  ],
  dependencies: [
    .package(url: "../", .branch("master")),
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
  ]
)
