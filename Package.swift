// swift-tools-version:4.0
import Foundation
import PackageDescription

var isDevelopment: Bool {
  return ProcessInfo.processInfo.environment["COMMANDER_SWIFTPM_DEVELOPMENT"] == "YES"
}

let package = Package(
  name: "Commander",
  products: [
    .library(name: "Commander", targets: ["Commander"]),
  ],
  dependencies: {
    var deps: [Package.Dependency] = []
    if isDevelopment {
      deps += [
        .package(url: "https://github.com/kylef/Spectre.git", from: "0.8.0"),
      ]
    }
    return deps
  }(),
  targets: {
    var t: [Target] = [.target(name: "Commander", dependencies: [])]
    if isDevelopment {
      t += [
        .testTarget(name: "CommanderTests", dependencies: ["Commander", "Spectre"]),
      ]
    }
    return t
  }()
)
