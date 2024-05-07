// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "KSCrash",
    products: [
        .library(
            name: "KSCrash",
            targets: [
                "KSCrash/Installations",
                "KSCrash/Recording",
                "KSCrash/Recording/Monitors",
                "KSCrash/Recording/Tools",
                "KSCrash/Reporting/Filters",
                "KSCrash/Reporting/Filters/Tools",
                "KSCrash/Reporting/Tools",
                "KSCrash/Reporting/Sinks"
            ]
        )
    ],
    dependencies: [
        .package(
            url: "https://github.com/embrace-io/swift-demangler.git",
            branch: "main"
        ),
    ],
    targets: [
        .target(
            name: "KSCrash/Installations",
            path: "Source/KSCrash/Installations",
            publicHeadersPath: ".",
            cxxSettings: [
                .headerSearchPath("../Recording"),
                .headerSearchPath("../Recording/Monitors"),
                .headerSearchPath("../Recording/Tools"),
                .headerSearchPath("../Reporting/Filters"),
                .headerSearchPath("../Reporting/Sinks"),
                .headerSearchPath("../Reporting/Tools"),
            ]
        ),
        .target(
            name: "KSCrash/Recording",
            path: "Source/KSCrash/Recording",
            exclude: [
                "Monitors",
                "Tools"
            ],
            publicHeadersPath: ".",
            cxxSettings: [
                .headerSearchPath("Tools"),
                .headerSearchPath("Monitors"),
                .headerSearchPath("../Reporting/Filters")
            ]
        ),
        .target(
            name: "KSCrash/Recording/Monitors",
            path: "Source/KSCrash/Recording/Monitors",
            publicHeadersPath: ".",
            cxxSettings: [
                .define("GCC_ENABLE_CPP_EXCEPTIONS", to: "YES"),
                .headerSearchPath(".."),
                .headerSearchPath("../Tools"),
                .headerSearchPath("../../Reporting/Filters")
            ]
        ),
        .target(
            name: "KSCrash/Recording/Tools",
            dependencies: [
                .product(name: "AppleSwiftDemangling", package: "swift-demangler")
            ],
            path: "Source/KSCrash/Recording/Tools",
            publicHeadersPath: ".",
            cxxSettings: [
                .headerSearchPath(".."),
                .headerSearchPath("../../swift"),
                .headerSearchPath("../../swift/Basic"),
                .headerSearchPath("../../llvm/ADT"),
                .headerSearchPath("../../llvm/Support"),
                .headerSearchPath("../../llvm/Config")
            ]
        ),
        .target(
            name: "KSCrash/Reporting/Filters",
            path: "Source/KSCrash/Reporting/Filters",
            exclude: [
                "Tools"
            ],
            publicHeadersPath: ".",
            cxxSettings: [
                .headerSearchPath("Tools"),
                .headerSearchPath("../../Recording"),
                .headerSearchPath("../../Recording/Monitors"),
                .headerSearchPath("../../Recording/Tools")
            ]
        ),
        .target(
            name: "KSCrash/Reporting/Filters/Tools",
            path: "Source/KSCrash/Reporting/Filters/Tools",
            publicHeadersPath: ".",
            cxxSettings: [
                .headerSearchPath("../../../Recording/Tools")
            ]
        ),
        .target(
            name: "KSCrash/Reporting/Tools",
            path: "Source/KSCrash/Reporting/Tools",
            publicHeadersPath: ".",
            cxxSettings: [
                .headerSearchPath("../../Recording"),
                .headerSearchPath("../../Recording/Tools")
            ]
        ),
        .target(
            name: "KSCrash/Reporting/Sinks",
            path: "Source/KSCrash/Reporting/Sinks",
            publicHeadersPath: ".",
            cxxSettings: [
                .headerSearchPath("../Filters"),
                .headerSearchPath("../Filters/Tools"),
                .headerSearchPath("../Tools"),
                .headerSearchPath("../../Recording"),
                .headerSearchPath("../../Recording/Tools"),
                .headerSearchPath("../../Recording/Monitors")
            ]
        )
    ],
    cxxLanguageStandard: .gnucxx11
)
