// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "SwiftDate",
    defaultLocalization: "it",
    platforms: [
        .macOS(.v10_15), .iOS(.v13), .watchOS(.v6), .tvOS(.v13)
    ],
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(name: "SwiftDate", targets: ["SwiftDate"])
    ],
    dependencies: [],
    targets: [
        .target(
            name: "SwiftDate",
            dependencies: [],
			resources: [
				.copy("Formatters/RelativeFormatter/langs"),
                .process("Resources")
			]),
        .testTarget(
            name: "SwiftDateTests",
            dependencies: ["SwiftDate"])
    ]
)
