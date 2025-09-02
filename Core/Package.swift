// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Core",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "Domain",
            targets: ["Domain"]
        ),
        .library(
            name: "DesignSystem",
            targets: ["DesignSystem"]
        ),
        .library(
            name: "NetworkService",
            targets: ["NetworkService"]
        ),
        .library(
            name: "StorageService",
            targets: ["StorageService"]
        )
    ],
    targets: [
        .target(
            name: "Domain"
        ),
        .target(
            name: "DesignSystem"
        ),
        .target(
            name: "NetworkService", dependencies: ["Domain"]
        ),
        .target(
            name: "StorageService"
        ),
        .testTarget(
            name: "NetworkServiceTests",
            dependencies: ["NetworkService", "Domain"]
        )
    ]
)

