// swift-tools-version:5.3

import Foundation
import PackageDescription

var sources = ["src/parser.c"]
if FileManager.default.fileExists(atPath: "src/scanner.c") {
    sources.append("src/scanner.c")
}

let package = Package(
    name: "TreeSitterLuna",
    products: [
        .library(name: "TreeSitterLuna", targets: ["TreeSitterLuna"]),
    ],
    dependencies: [
        .package(name: "SwiftTreeSitter", url: "https://github.com/tree-sitter/swift-tree-sitter", from: "0.8.0"),
    ],
    targets: [
        .target(
            name: "TreeSitterLuna",
            dependencies: [],
            path: ".",
            sources: sources,
            resources: [
                .copy("queries")
            ],
            publicHeadersPath: "bindings/swift",
            cSettings: [.headerSearchPath("src")]
        ),
        .testTarget(
            name: "TreeSitterLunaTests",
            dependencies: [
                "SwiftTreeSitter",
                "TreeSitterLuna",
            ],
            path: "bindings/swift/TreeSitterLunaTests"
        )
    ],
    cLanguageStandard: .c11
)
