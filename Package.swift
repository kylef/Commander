import PackageDescription

let package = Package(
  name: "Commander",
  testDependencies: [
    .Package(url: "https://github.com/kylef/Spectre", majorVersion: 0, minor: 6),
  ]
)
