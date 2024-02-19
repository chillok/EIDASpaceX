import SwiftUI
import SwiftData

struct LaunchDetailView<ViewModel: LaunchDetailViewModelProtocol>: View {
    
    @ObservedObject var viewModel: ViewModel
    @Query private var crew: [CrewMember]
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        
//        _crew = Query(filter: #Predicate<[CrewMember]> {
//            viewModel.data.crew.flatMap { viewModel.contains($0.id) } == true
//        })
        
//        _crew = Query(filter: #Predicate<CrewMember> { storedCrew in
//            viewModel.crew.contains { vmCrew in
//                vmCrew.id == storedCrew.id
//            }
//        })
    }
    
    var body: some View {
        VStack {
            List {
                Section {
                    VStack(alignment: .center) {
                        VStack {
                            if let patch = viewModel.data.patch, let url = URL(string: patch) {
                                AsyncImage(url: url) { image in
                                    image
                                        .resizable()
                                        .clipped()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(maxHeight: 200)
                                        .padding()
                                        .background(.ultraThinMaterial, in: RoundedRectangle(cornerSize: CGSize(width: 20, height: 10), style: .continuous))
                                } placeholder: {
                                    ProgressView()
                                }
                            }
                            
                            Text(viewModel.data.name)
                                .multilineTextAlignment(.center)
                                .font(.title)
                                .fontDesign(.monospaced)
                                .fontWeight(.bold)
                                .foregroundStyle(.secondary)
                                .padding()
                        }
                    }
                    .background(
                        // blurred background patch
                        Image("patch")
                            .resizable()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .aspectRatio(contentMode: .fill)
                            .blur(radius: 50)
                            .edgesIgnoringSafeArea(.all)
                    )
                }
                .listRowSeparator(.hidden)
                .frame(maxWidth: .infinity)

                Section {
                    ScrollView(.horizontal) {
                        LazyHStack {
                            
                            ForEach(crew) { member in
                                VStack {
                                    Image(systemName: "person.circle")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 50, height: 50)
                                    
                                    Text("Firstname lastname")
                                        .multilineTextAlignment(.center)
                                        .fixedSize(horizontal: false, vertical: true)
                                    
                                }.frame(maxWidth: 100)
                            }
                        }
                        .padding()
                    }

                } header: {
                    Text("Crew")
                }
                    
                Section {
                    
                } header: {
                    Text("Rocket")
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
