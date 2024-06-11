import Foundation

final class DetailViewModel: ObservableObject {
    private let api: Api
    private let secureStorage: SecureStorage

    init(api: Api, secureStorage: SecureStorage) {
        self.api = api
        self.secureStorage = secureStorage
    }

    deinit {
        print("Dealloc of \(self)")
    }
}

