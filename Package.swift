// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "SwiftDate",
    platforms: [
        .macOS(.v10_10), .iOS(.v9), .watchOS(.v2), .tvOS(.v9)
    ],
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(name: "SwiftDate", targets: ["SwiftDate"]),
        .library(name: "SwiftDateStatic", type: .static, targets: ["SwiftDate"]),
        .library(name: "SwiftDateDynamic", type: .dynamic, targets: ["SwiftDate"])
    ],
    dependencies: [],
    targets: [
        .target(
            name: "SwiftDate",
            dependencies: [],
			resources: [
				.copy("Formatters/RelativeFormatter/langs")
			]),
        .testTarget(
            name: "SwiftDateTests",
            dependencies: ["SwiftDate"])
    ]
)
