import Foundation

public protocol Resolver: AnyObject {
    func resolve<Service>(_ type: Service.Type) -> Service
}

public final class Container: @unchecked Sendable {
    private var storage: [String: Any] = [:]

    public init() { }

    public func register<Service>(_ type: Service.Type, factory: @escaping (Resolver) -> Service) {
        let key = "\(type)"
        storage[key] = factory
    }
}

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
}
