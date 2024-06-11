import Foundation
import SwinjectLight

final class AppDependencyInjectionContainer {
    static let shared = AppDependencyInjectionContainer()

    var container = Container()

    private init() { }

    func register() {
        container.register(Api.self) { r in
            Networking(session: r.resolve(Session.self))
        }

        container.register(SecureStorage.self) { _ in
            Keychain()
        }

        container.register(RootViewModel.self) { r in
            RootViewModel()
        }

        container.register(Session.self) { r in
            DefaultSession.shared
        }

        container.register(RootAppView.self) { r in
            RootAppView(viewModel: r.resolve(RootViewModel.self))
        }

        container.register(DetailViewModel.self) { r in
            DetailViewModel(api: r.resolve(Api.self), secureStorage: r.resolve(SecureStorage.self))
        }

        container.register(DetailView.self) { r in
            DetailView(viewModel: r.resolve(DetailViewModel.self))
        }
    }
}
