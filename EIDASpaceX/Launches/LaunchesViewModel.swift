import Foundation
import Combine
import SwiftUI
import SwiftData

protocol LaunchesViewModelProtocol: ObservableObject {
    
    var selection: LaunchesViewModel.LaunchesViewSelection { get set }
    var allAvailableSelections: [LaunchesViewModel.LaunchesViewSelection] { get }
    var searchText: String { get set }
    var launches: DataState<[LaunchViewViewModel]> { get set }
    
    init(webservice: WebserviceProtocol,
         storage: StorageProtocol,
         router: LaunchesRouterProtocol)
    
    func retrieveLaunches()
    func resetLaunches()
    func selectLaunch(from viewModel: LaunchViewViewModel) -> AnyView
}

class LaunchesViewModel: LaunchesViewModelProtocol, ObservableObject {
    
    enum LaunchesViewSelection: CaseIterable, Identifiable, CustomStringConvertible {
        case all
        case successful
        case failed
        
        var id: Self { self }
        
        var description: String {
            switch self {
            case .all: return "All"
            case .successful: return "Success"
            case .failed: return "Failed"
            }
        }
    }
    
    private var webservice: WebserviceProtocol
    private var storage: StorageProtocol
    private var router: LaunchesRouterProtocol
    
    // A cached copy of the data, used for filtering so we don't have to refetch if we filter the list
    private var cachedLaunches: [LaunchViewViewModel] = []
    // A 'live' version of the data, used to display on list
    @Published var launches: DataState<[LaunchViewViewModel]> = .initial
    
    @Published var selection = LaunchesViewSelection.all {
        didSet {
            Task {
                await MainActor.run {
                    launches = .loaded(filter(cachedLaunches, with: selection))
                }
            }
        }
    }
    
    @Published var searchText: String = "" {
        didSet {
            Task {
                await MainActor.run {
                    if searchText == "" {
                        launches = .loaded(filter(cachedLaunches, with: selection))
                    } else {
                        launches = .loaded(filter(cachedLaunches, with: searchText))
                    }
                }
            }
        }
    }
    
    var allAvailableSelections: [LaunchesViewSelection] {
        return LaunchesViewSelection.allCases
    }
 
    required init(webservice: WebserviceProtocol, storage: StorageProtocol, router: LaunchesRouterProtocol) {
        self.webservice = webservice
        self.storage = storage
        self.router = router
    }
    
    func retrieveLaunches() {
        
        Task {
            do {
                let mapper = LaunchToViewModelMapper()
                
                // retrieve from storage first and update UI, if any
                let cachedModels = try storage.retrieveAll()
                    .map { mapper.map(launch: $0) }
                    .sortedForLaunchView()
                
                if !cachedModels.isEmpty {
                    await updateUI(cachedModels)
                } else {
                    // if we have nothing cached, we'll set the UI state to loading so to not show an empty list
                    await resetUIToLoading()
                }
                
                // retrieve from api and persist to storage
                let remoteLaunches = try await webservice.retrieveLaunches()
                try storage.store(remoteLaunches)
                
                let remoteModels = remoteLaunches.map {
                    mapper.map(launch: $0)
                }.sortedForLaunchView()
                
                await updateUI(remoteModels)
            } catch {
                print(error)
                await MainActor.run {
                    self.launches = .failed
                }
            }
        }
    }
    
    func selectLaunch(from viewModel: LaunchViewViewModel) -> AnyView {
        router.showDetail(from: viewModel)
    }
    
    @MainActor
    func resetLaunches() {
        launches = .loaded(filter(cachedLaunches, with: selection))
    }
    
    @MainActor
    private func updateUI(_ viewViewModels: [LaunchViewViewModel]) {
        self.cachedLaunches = viewViewModels
        self.launches = .loaded(viewViewModels)
    }
    
    @MainActor
    private func resetUIToLoading() {
        self.cachedLaunches = []
        self.launches = .loading
    }
    
    private func filter(_ launches: [LaunchViewViewModel], with selection: LaunchesViewSelection) -> [LaunchViewViewModel] {
        launches.filter { model in
            switch selection {
            case .all: return true
            case .failed: return model.success == false
            case .successful: return model.success == true
            }
        }
    }
    
    private func filter(_ launches: [LaunchViewViewModel], with text: String) -> [LaunchViewViewModel] {
        filter(launches.filter { model in
            model.name.contains(text)
        }, with: selection)
    }
}
