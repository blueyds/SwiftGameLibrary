// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftGameLibrary",
    platforms: [ .iOS(.v16),
                .macOS(.v13)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library( name: "SwiftGameLibrary", targets: ["SwiftGameLibrary"]),
        .library( name: "SwiftGameTypes", targets: ["SwiftGameTypes"]),
        .library( name: "SwiftGameMeshes", targets: ["SwiftGameMeshes"]),
        .library( name: "SwiftGameInputs", targets: ["SwiftGameInputs"]),
        .library( name: "SwiftGameEngine", targets: ["SwiftGameEngine"]),
        
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "SwiftGameLibrary",
            dependencies: [ 
                .target(name: "SwiftGameTypes"),
                .target(name: "SwiftGameMeshes"),
                .target(name: "SwiftGameInputs"),
                .target(name: "SwiftGameEngine"),
            ]
        )
        .target(
        name: "SwiftGameMeshes",
            dependencies: [ 
                .target(name: "SwiftGameTypes"),
            ]
        )
        .target(
            name: "SwiftGameInputs",
            dependencies: [ 
                .target(name: "SwiftGameTypes"),
            ]
        )
        .target(
            name: "SwiftGameTypes")
        .target(
            name: "SwiftGameEngine",
            dependencies: [ 
                .target(name: "SwiftGameTypes"),
                ]
        )

        .testTarget(
            name: "SwiftGameLibraryTests",
            dependencies: ["SwiftGameLibrary"]),
    ]
)

