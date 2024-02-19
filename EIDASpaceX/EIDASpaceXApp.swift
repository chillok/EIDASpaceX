import SwiftUI

@main
struct EIDASpaceXApp: App {
    var body: some Scene {
        WindowGroup {
            LaunchesView(viewModel: LaunchesViewModel(webservice: Webservice(),
                                                      storage: Storage(),
                                                      router: LaunchesRouter()))
            .modelContainer(Storage.shared.modelContainer)
        }
    }
}
