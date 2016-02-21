import PackageDescription

let package = Package(
    name: "Nimble",
    targets: [
        Target(name: "NimbleTests", dependencies: [.Target(name: "Nimble")])
    ]
)
