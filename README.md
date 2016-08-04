# ValidatedInjectAdditions
ValidatedInjectAdditions adds some convenience methods for projects that are using (EasyInject)[https://www.github.com/vknabel/EasyInject] and (ValidatedExtension)[https://www.github.com/vknabel/ValidatedExtension].

## Installation
EasyInject is a Swift only project and supports [Swift Package Manager](https://github.com/apple/swift-package-manager), [Carthage](https://github.com/Carthage/Carthage) and [CocoaPods](https://github.com/CocoaPods/CocoaPods).

### Swift Package Manager

```swift
import PackageDescription

let package = Package(
    name: "YourPackage",
    dependencies: [
        .Package(url: "https://github.com/vknabel/EasyInject.git", majorVersion: 0, minor: 3),
        .Package(url: "https://github.com/vknabel/ValidatedExtension.git", majorVersion: 3, minor: 0),
        .Package(url: "https://github.com/vknabel/ValidatedInjectAdditions.git", majorVersion: 0, minor: 1)
    ]
)
```

### Carthage

```ruby
github "vknabel/EasyInject" ~> 0.3
github "vknabel/ValidatedExtension" ~> 3.0
github "vknabel/ValidatedInjectAdditions.git" ~> 0.1
```

### CocoaPods

```ruby
source 'https://github.com/CocoaPods/Specs.git'
use_frameworks!

pod 'EasyInject', '~> 0.2'

pod 'EasyInject', '~> 0.3'
pod 'ValidatedExtension', '~> 3.0'
pod 'ValidatedInjectAdditions.git', '~> 0.1'
```

## Example

This code snippet is built on top of (EasyInject)[https://www.github.com/vknabel/EasyInject/README.md]'s example. 

```swift
import EasyInject
import ValidatedExtension
import ValidatedInjectAdditions

// Define your a Validator as known from ValidatedExtension
struct NetworkServiceInjectorValidator: Validator {
    typealias WrappedType = AnyInjector<String>
    static func validate(_ value: AnyInjector<String>) throws -> Bool {
        let base = try value.resolving(from: .baseUrl)
        return URL(string: base)
            .flatMap({ _ in true })
            ?? false
    }
}

// Add properties to Validated<NetworkServiceInjectorValidator>
extension ValidatedType where ValidatorType == NetworkServiceInjectorValidator {
    var baseUrl: String {
        return try! value.resolving(from: .baseUrl)
    }
}

final class NetworkService: Providable, ValidatedDependency {
    // Declare your dependency
    typealias DependencyValidator = NetworkServiceInjectorValidator

    let baseUrl: String
    init<VT : ValidatedType where VT.ValidatorType == DependencyValidator>(validated dependencies: VT) {
        // Just focus on setting thing up 
        baseUrl = dependencies.baseUrl
    }
}

var injector = LazyInjector<String>().globalize().erase()
injector.provide(for: .baseUrl, usingFactory: { _ in "https://my.base.url/" })

// this will throw an error if .baseUrl is missing
// Otherwise initializes NetworkService
let networkService = try NetworkService(injector: &injector)
```

## Author

Valentin Knabel, develop@vknabel.com

## License

ValidatedInjectAdditions is available under the MIT license. See the LICENSE file for more info.
