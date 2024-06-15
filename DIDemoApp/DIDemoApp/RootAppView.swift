import SwiftUI

struct RootAppView: View {
    @ObservedObject var viewModel: RootViewModel

    var body: some View {
        Button("Show Detail") {
            viewModel.delegate?.showDetailScreen()
        }
    }
}
