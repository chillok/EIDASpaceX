import Foundation
import Combine

protocol LaunchDetailViewModelProtocol: ObservableObject {
    
    var data: LaunchViewViewModel { get set }
    var crew: [CrewMember] { get set }
    var rocket: Rocket? { get set }
    
    init(viewModel: LaunchViewViewModel,
         webservice: WebserviceProtocol,
         storage: StorageProtocol)
    
    func retrieveData()
}

class LaunchDetailViewModel: LaunchDetailViewModelProtocol {
    
    private var webservice: WebserviceProtocol
    private var storage: StorageProtocol
    
    @Published var data: LaunchViewViewModel
    @Published var crew: [CrewMember] = []
    @Published var rocket: Rocket? = nil
    
    required init(viewModel: LaunchViewViewModel, webservice: WebserviceProtocol, storage: StorageProtocol) {
        data = viewModel
        self.webservice = webservice
        self.storage = storage
    }
    
    func updateCrew() {
        
//        guard
//            let crewIds = data.crew,
//            !crewIds.isEmpty else {
//            crew = .loaded([])
//            return
//        }
//        
//        Task {
//            await MainActor.run {
//                let crew = crewIds.compactMap { storage.retrieve(id: $0) }
//                self.crew = .loaded(crew)
//            }
//        }
    }
    
    func updateRocket() {
        
    }
    
    func retrieveData() {
        Task {
            let crew = try await webservice.retrieveCrew()
            try storage.store(crew)
            
//            let rockets = try await webservice.retrieveRockets()
//            try storage.store(rockets)
        }
    }
}
