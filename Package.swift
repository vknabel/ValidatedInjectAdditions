import PackageDescription

let package = Package(
    name: "ValidatedInjectAdditions",
    dependencies: [
        .Package(
            url: "git@github.com:vknabel/EasyInject.git",
            versions: Version(0,3,0)..<Version(0,4,0)),
        .Package(
            url: "git@github.com:vknabel/ValidatedExtension.git",
            versions: Version(3,0,0)..<Version(4,0,0))
    ]
)
