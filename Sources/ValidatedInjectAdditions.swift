import ValidatedExtension
import EasyInject

public protocol ValidatedDependency {
    associatedtype DependencyValidator: Validator

    init<VT: ValidatedType>(validated dependencies: VT)
        where VT.ValidatorType == DependencyValidator
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
    public init(injector: inout DependencyValidator.WrappedType) throws {
        try self.init(extracting: injector)
    }
}
public extension ValidatedDependency where DependencyValidator.WrappedType: Injector {
    public init(injector: DependencyValidator.WrappedType) throws {
        try self.init(extracting: injector)
    }
}
