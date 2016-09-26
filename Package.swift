import PackageDescription

let package = Package(
    name: "ValidatedInjectAdditions",
    dependencies: [
        .Package(
            url: "https://github.com/vknabel/EasyInject.git",
            versions: Version(0,8,0)..<Version(0,9,0)),
        .Package(
            url: "https://github.com/vknabel/ValidatedExtension.git",
            versions: Version(4,0,0)..<Version(5,0,0))
    ]
)
