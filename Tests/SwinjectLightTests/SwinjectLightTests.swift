import XCTest
@testable import SwinjectLight

private protocol MockDependency: AnyObject { }
private class MockClass: MockDependency { }

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

    func testSharedInstace() {
        let container = Container()
        let localVariable = MockClass()
        container.register(MockDependency.self) { _ in
            localVariable
        }
        let resolvedDependency = container.resolve(MockDependency.self)
        XCTAssertTrue(resolvedDependency is MockClass)
        XCTAssertTrue(localVariable === resolvedDependency)
    }
}
