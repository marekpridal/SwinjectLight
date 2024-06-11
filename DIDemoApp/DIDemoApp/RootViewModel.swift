import Foundation

protocol RootViewModelDelegate: AnyObject {
    func showDetailScreen()
}

final class RootViewModel: ObservableObject {
    weak var delegate: RootViewModelDelegate?

    deinit {
        print("Dealloc of \(self)")
    }
}
