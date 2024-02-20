import Foundation
import SwiftUI

protocol LaunchesRouterProtocol {
    func showDetail(from viewModel: LaunchViewViewModel) -> AnyView
}

final class LaunchesRouter: LaunchesRouterProtocol {
    func showDetail(from viewModel: LaunchViewViewModel) -> AnyView {
        AnyView(LaunchDetailView(viewModel: 
                                    LaunchDetailViewModel(viewModel: viewModel,
                                                          webservice: Webservice(),
                                                          storage: Storage.shared)).modelContainer(Storage.shared.modelContainer))
    }
}
