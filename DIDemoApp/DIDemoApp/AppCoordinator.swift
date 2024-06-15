import Foundation
import UIKit
import SwiftUI
import SwinjectLight

final class AppCoordinator {
    private let container: Container
    private let rootNavigationController: UINavigationController

    init(container: Container, navigationController: UINavigationController) {
        self.container = container
        self.rootNavigationController = navigationController
    }

    func showAppView() {
        let view = container.resolve(RootAppView.self)
        view.viewModel.delegate = self
        rootNavigationController.setViewControllers([UIHostingController(rootView: view)], animated: false)
    }
}

extension AppCoordinator: RootViewModelDelegate {
    func showDetailScreen() {
        let view = container.resolve(DetailView.self)
        rootNavigationController.pushViewController(UIHostingController(rootView: view), animated: true)
    }
}
