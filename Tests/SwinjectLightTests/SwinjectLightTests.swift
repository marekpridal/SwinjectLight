import XCTest
@testable import SwinjectLight

private protocol MockDependency: AnyObject { }
private protocol MockParametersDependency: AnyObject { }
private class MockClass: MockDependency { }
private class MockClassWithParameters: MockParametersDependency {
    struct Parameters: Equatable {
        let foo: String
    }

    let parameters: Parameters
    let dependency: MockDependency

    init(dependency: MockDependency, parameters: Parameters) {
        self.dependency = dependency
        self.parameters = parameters
    }
}

#if canImport(Darwin)
@MainActor
#endif
final class SwinjectLightTests: XCTestCase {
    func testRegisterAndResolve() {
        let container = Container()
        let localVariable = MockClass()
        container.register(MockDependency.self) { _ in
            MockClass()
        }
        let resolvedDependency = container.resolve(MockDependency.self)
        XCTAssertTrue(resolvedDependency is MockClass)
        XCTAssertFalse(localVariable === resolvedDependency)
    }

    func testSharedInstance() {
        let container = Container()
        let localVariable = MockClass()
        container.register(MockDependency.self) { _ in
            localVariable
        }
        let resolvedDependency = container.resolve(MockDependency.self)
        XCTAssertTrue(resolvedDependency is MockClass)
        XCTAssertTrue(localVariable === resolvedDependency)
    }

    func testRegisterAndResolveWithParameters() {
        let container = Container()
        let parameters = MockClassWithParameters.Parameters(foo: "foo")
        container.register(MockDependency.self) { _ in MockClass() }
        container.register(MockParametersDependency.self, parametersType: MockClassWithParameters.Parameters.self) { resolver, parameters in
            MockClassWithParameters(dependency: resolver.resolve(MockDependency.self), parameters: parameters)
        }

        let resolvedDependency = container.resolve(MockParametersDependency.self, parameters: parameters)
        XCTAssertTrue(resolvedDependency is MockClassWithParameters)
        XCTAssertTrue((resolvedDependency as? MockClassWithParameters)?.dependency is MockDependency)
        XCTAssertEqual((resolvedDependency as? MockClassWithParameters)?.parameters, parameters)
    }
}
