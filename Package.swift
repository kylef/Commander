import PackageDescription

let package = Package(
  name: "Commander",
  testDependencies: [
    .Package(url: "https://github.com/kylef/spectre-build", majorVersion: 0),
  ]
)
