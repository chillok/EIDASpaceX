import Foundation
import Combine

protocol LaunchDetailViewModelProtocol: ObservableObject {
    
    var data: LaunchViewViewModel { get set }
    
    init(viewModel: LaunchViewViewModel,
         webservice: WebserviceProtocol,
         storage: StorageProtocol)
    
    func retrieveData()
}

class LaunchDetailViewModel: LaunchDetailViewModelProtocol {
    
    private var webservice: WebserviceProtocol
    private var storage: StorageProtocol
    
    @Published var data: LaunchViewViewModel
    
    required init(viewModel: LaunchViewViewModel, webservice: WebserviceProtocol, storage: StorageProtocol) {
        data = viewModel
        self.webservice = webservice
        self.storage = storage
    }

    func retrieveData() {
        Task {
            let crew = try await webservice.retrieveCrew()
            try storage.store(crew)
            
            let rockets = try await webservice.retrieveRockets()
            try storage.store(rockets)
        }
    }
}
