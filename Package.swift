// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "SwiftDate",
    products: [
        .library(
            name: "SwiftDate",
            targets: ["SwiftDate"])
    ],
    dependencies: [],
    targets: [
        .target(
            name: "SwiftDate",
            dependencies: []),
        .testTarget(
            name: "SwiftDateTests",
            dependencies: ["SwiftDate"])
    ]
)
