import ValidatedExtension
import EasyInject

public protocol ValidatedDependency {
    associatedtype DependencyValidator: Validator

    #if swift(>=3.0)
    init<VT: ValidatedType>(validated dependencies: VT) where VT.ValidatorType == DependencyValidator
    #else
    init<VT: ValidatedType where VT.ValidatorType == DependencyValidator>(validated dependencies: VT)
    #endif
}
public extension ValidatedDependency {
    public init?(validating dependencies: DependencyValidator.WrappedType) {
        guard let dependencies = Validated<DependencyValidator>(value: dependencies)
            else { return nil }
        self.init(validated: dependencies)
    }

    public init(extracting dependencies: DependencyValidator.WrappedType) throws {
        self.init(validated: try Validated<DependencyValidator>(dependencies))
    }
}

public extension ValidatedDependency where DependencyValidator.WrappedType: MutableInjector {
    #if swift(>=3.0)
    public init(injector: inout DependencyValidator.WrappedType) throws {
        try self.init(extracting: injector)
    }
    #else
    public init(inout injector: DependencyValidator.WrappedType) throws {
        try self.init(extracting: injector)
    }
    #endif
}
public extension ValidatedDependency where DependencyValidator.WrappedType: Injector {
    public init(injector: DependencyValidator.WrappedType) throws {
        try self.init(extracting: injector)
    }
}
