// swift-tools-version:5.3
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
            dependencies: []
			resources: [
				.copy("Formatters/RelativeFormatter/langs")
			]),
        .testTarget(
            name: "SwiftDateTests",
            dependencies: ["SwiftDate"])
    ]
)
