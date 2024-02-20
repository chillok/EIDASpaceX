import Foundation
import SwiftUI
@testable import EIDASpaceX

class MockRouter: LaunchesRouterProtocol {
    var showDetailCalled = false
    func showDetail(from viewModel: EIDASpaceX.LaunchViewViewModel) -> AnyView {
        showDetailCalled = true
        return AnyView(Text(""))
    }
}
