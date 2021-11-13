// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "VivekDev",
    products: [
        .executable(
            name: "VivekDev",
            targets: ["VivekDev"]
        )
    ],
    dependencies: [
        .package(name: "Publish", url: "https://github.com/johnsundell/publish.git", from: "0.6.0"),
        .package(url: "https://github.com/SwiftyGuerrero/CNAMEPublishPlugin", from: "0.1.0"),
        .package(url: "https://github.com/Ze0nC/SwiftPygmentsPublishPlugin", .branch("master")),
        .package(name: "DarkImagePublishPlugin", url: "https://github.com/insidegui/DarkImagePublishPlugin", from: "0.1.0"),
        .package(name: "MinifyCSSPublishPlugin", url: "https://github.com/labradon/minifycsspublishplugin", from: "0.1.0")
    ],
    targets: [
        .target(
            name: "VivekDev",
            dependencies: [
                "Publish",
                "CNAMEPublishPlugin",
                "SwiftPygmentsPublishPlugin",
                "DarkImagePublishPlugin",
                "MinifyCSSPublishPlugin"]
        )
    ]
)
