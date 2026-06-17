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
     dependencies: [
        .package(url: "https://github.com/shang1219178163/SwiftExpand.git", from: "8.2.0")
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
