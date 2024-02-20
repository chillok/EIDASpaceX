import SwiftUI
import SwiftData

struct LaunchDetailView<ViewModel: LaunchDetailViewModelProtocol>: View {
    
    @ObservedObject var viewModel: ViewModel
    @Query private var crew: [CrewMember]
    
    var filteredCrew: [CrewMember] {
        crew.filter { member in
            return viewModel.data.crew?.contains(member.id) == true
        }
    }
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            List {
                
                PatchSectionView(viewModel: viewModel.data)
                
                if let details = viewModel.data.details {
                    Section {
                        Text(details)
                    }
                }

                if !filteredCrew.isEmpty {
                    Section {
                        ScrollView(.horizontal) {
                            LazyHStack {
                                ForEach(filteredCrew) { member in
                                    CrewCellView(member: member)
                                        .frame(width: 100)
                                }
                            }
                            .padding()
                        }
                    } header: {
                        Text("Crew")
                    }
                    .frame(height: 100)
                }
                
                if let id = viewModel.data.rocket {
                    RocketView(id: id)
                }
            }
            .listStyle(PlainListStyle())
            
        }
        .navigationBarTitle("")
        .onAppear(perform: {
            viewModel.retrieveData()
        })
    }
}

#Preview {
    LaunchDetailView(viewModel: LaunchDetailViewModel(viewModel: .init(id: "sadasd", flightNumber: 2, name: "5dftgyuhn"), webservice: Webservice(), 
                                                      storage: Storage()))
}
