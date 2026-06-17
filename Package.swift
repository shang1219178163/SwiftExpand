// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "SwiftExpand",
    platforms: [
        .iOS(.v11),
        .macOS(.v10_13),
    ],
    products: [
        .library(
            name: "SwiftExpand",
            targets: ["SwiftExpand"]
        ),
    ],
    targets: [
        .target(
            name: "SwiftExpand",
            path: "SwiftExpand",
            sources: [
                "Classes",
                "ios",
                "osx",
            ],
            resources: [
                .process("Assets.xcassets"),
            ]
        ),
    ]
)
