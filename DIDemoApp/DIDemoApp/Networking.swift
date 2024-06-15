import Foundation

final class Networking: Api {
    let session: Session

    init(session: Session) {
        self.session = session
    }

    deinit {
        print("Dealloc of \(self)")
    }
}
