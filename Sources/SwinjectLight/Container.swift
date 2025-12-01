import Foundation

#if canImport(Darwin)
@MainActor
#endif
public protocol Resolver: AnyObject {
    func resolve<Service>(_ type: Service.Type) -> Service
    func resolve<Service, Parameters>(_ type: Service.Type, parameters: Parameters) -> Service
}

public final class Container {
    private var storage: [String: Any] = [:]

    public init() { }

    public func register<Service>(_ type: Service.Type, factory: @escaping (Resolver) -> Service) {
        let key = "\(type)"
        storage[key] = factory
    }

    public func register<Service, Parameters>(_ type: Service.Type,
                                              parametersType: Parameters.Type,
                                              factory: @escaping (Resolver, Parameters) -> Service) {
        let key = "\(type)"
        storage[key] = factory
    }
}

#if !canImport(Darwin)
extension Container: @unchecked Sendable { }
#endif

extension Container: Resolver {
    public func resolve<Service>(_ type: Service.Type) -> Service {
        let key = "\(type)"
        guard let factory = storage[key] else {
            fatalError("Dependency \(key) has not been registered")
        }
        guard let typedFactory = factory as? (((Resolver) -> Service)?) else {
            fatalError("Dependency \(key) did not provide factory closure")
        }
        let service = typedFactory?(self)
        return service!
    }

    public func resolve<Service, Parameters>(_ type: Service.Type, parameters: Parameters) -> Service {
        let key = "\(type)"
        guard let factory = storage[key] else {
            fatalError("Dependency \(key) has not been registered")
        }
        guard let typedFactory = factory as? (((Resolver, Parameters) -> Service)?) else {
            fatalError("Dependency \(key) did not provide factory closure")
        }
        let service = typedFactory?(self, parameters)
        return service!
    }
}
