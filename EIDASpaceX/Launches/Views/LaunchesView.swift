import SwiftUI
import Combine
import SwiftData

private struct Constants {
    static let pickerText = "Choose from All, Successful or Failed Launches"
    static let titleText = "Launches"
}

struct LaunchesView<ViewModel: LaunchesViewModelProtocol>: View {
    
    @ObservedObject var viewModel: ViewModel
    @Environment(\.isSearching) var isSearching
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            VStack {
                
                switch viewModel.launches {
                case .initial:
                    EmptyView()
                    
                case .loading:
                    LoadingView()
                    
                case let .loaded(launches):
                    
                    List(launches) { launch in
                        LaunchCellView(model: launch)
                            .background(
                                NavigationLink("", destination: {
                                    viewModel.selectLaunch(from: launch)
                                }).opacity(0)
                            )
                    }
                    .listRowSeparator(.hidden)
                    .searchable(text: $viewModel.searchText)
                    .onChange(of: isSearching, { oldValue, newValue in
                        if !newValue {
                            viewModel.resetLaunches()
                        }
                    })
                    .listStyle(PlainListStyle())
                    .refreshable {
                        viewModel.retrieveLaunches()
                    }
                    
                case .failed:
                    FailedView {
                        viewModel.retrieveLaunches()
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Picker(Constants.pickerText,
                       selection: $viewModel.selection) {
                        ForEach(viewModel.allAvailableSelections) { option in
                            Text(option.description)
                        }
                    }
                   .pickerStyle(.segmented)
                   .padding([.leading, .trailing])
                }
            }
            .navigationTitle(Constants.titleText)
            .onAppear(perform: {
                if viewModel.searchText.isEmpty {
                    viewModel.retrieveLaunches()
                }
            })
        }
    }
}

#Preview {
    LaunchesView(viewModel: LaunchesViewModel(webservice: Webservice(),
                                              storage: Storage.shared,
                                              router: LaunchesRouter()))
}
