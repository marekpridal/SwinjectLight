# SwinjectLight

![Build](https://github.com/marekpridal/SwinjectLight/workflows/test/badge.svg?branch=main) ![platforms](https://img.shields.io/badge/platform-iOS%20%7C%20watchOS%20%7C%20tvOS%20%7C%20macOS%20%7C%20Windows%20%7C%20Ubuntu-333333) [![Swift Package Manager compatible](https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg)](https://github.com/apple/swift-package-manager) ![GitHub](https://img.shields.io/github/license/marekpridal/SwinjectLight) ![GitHub All Releases](https://img.shields.io/github/downloads/marekpridal/SwinjectLight/total)

SwinjectLight is framework for lightweight dependency injection which works on any platform supporting Swift. Framework took inspiration from original [Swinject](https://github.com/Swinject/Swinject) implementation but removes some more complext functionality which is usually not necessary.

## Installation

### [Swift Package Manager](https://github.com/apple/swift-package-manager)

To add a package dependency to your Xcode project, select File > Add Package Dependency and `https://github.com/marekpridal/SwinjectLight`.

Alternatively in `Package.swift` add the following

```swift
// swift-tools-version:5.10

import PackageDescription

let package = Package(
  name: "SwinjectLightExample",
  dependencies: [
    .package(url: "https://github.com/marekpridal/SwinjectLight", from: "1.0.0")
  ],
  targets: [
    .target(name: "SwinjectLightExample", dependencies: ["SwinjectLight"])
  ]
)
```

## Usage
```swift
import SwinjectLight

// Create container
let container = Container()

// Register singleton dependency
container.register(Session.self) { r in
    DefaultSession.shared
}

// Register instance based dependency
container.register(Api.self) { r in
    Networking(session: r.resolve(Session.self))
}

// Resolve dependency
let api = container.resolve(Api.self)
```

You can also check out [demo project in repo](DIDemoApp) for further details about usage.