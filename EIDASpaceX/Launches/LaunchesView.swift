import SwiftUI
import Combine

class ContentViewViewModel: ObservableObject {
    
    @Published var selection = Selection.all {
        didSet {
            print(selection)
        }
    }
    
    var searchText: String = ""
}

enum Selection: CaseIterable, Identifiable, CustomStringConvertible {
    case all
    case past
    case future
    
    var id: Self { self }
    
    var description: String {
        switch self {
        case .all: return "All"
        case .past: return "Past"
        case .future: return "Future"
        }
    }
}

struct LaunchesView: View {
    
    @StateObject var viewModel = ContentViewViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                
            
            Picker("Choose from All, Past or Future Launches",
                   selection: $viewModel.selection) {
                ForEach(Selection.allCases) { option in
                    Text(option.description)
                }
            }
           .pickerStyle(.segmented)
           .padding([.leading, .trailing])
                
            List {
                
                VStack(alignment: .leading) {
                    
                    HStack {
                        Text("FalconSat")
                            .font(.title3)
                            .fontDesign(.monospaced)
                        
                        Spacer()
                        
                        Text("1")
                            .frame(width: 24, height: 24, alignment: .center)
                            .background(Circle().fill(Color.gray.quaternary))
                            .fontDesign(.monospaced)
                            .foregroundStyle(Color.white)
                            
                    }
                    
                    HStack {
                        Image(systemName: "calendar")
                        Text("Fri 16th Feb 2024 • 20:05")
                    }
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    
                    Spacer()
                        
                    HStack {
                        Text("🚀")
                        Text("Successful Launch")
                    }
                    .foregroundStyle(.green)
                    .font(.footnote)
                    
                    /*
                    Text("Engine failure at 33 seconds and loss of vehicle")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                    */
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(Color.green.quinary)
                .clipShape(RoundedRectangle(cornerRadius: 12.0))
                .listRowSeparator(.hidden)
                
                VStack(alignment: .leading) {
                    
                    HStack {
                        
                        Text("FalconSat")
                            .font(.title3)
                            .fontWeight(.bold)
                            .fontDesign(.monospaced)
                        
                        Spacer()
                        
                        Text("2")
                            .frame(width: 24, height: 24, alignment: .center)
                            .background(Circle().fill(Color.gray.quaternary))
                            .fontDesign(.monospaced)
                            .fontWeight(.bold)
                            .foregroundStyle(Color.primary)
                    }
                    
                    HStack {
                        Image(systemName: "calendar")
                        Text("Fri 16/02/24 • 20:05")
                            .textCase(.uppercase)
                    }
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                    
                    Spacer()
                    
                    HStack {
                        Text("⛔️")
                        Text("Unsuccessful Launch")
                    }
                    .foregroundStyle(.red)
                    .font(.footnote)
                    .textCase(.uppercase)
                    .fontWeight(.medium)
                    
                    Text("Engine failure at 33 seconds and loss of vehicle")
                        .font(.footnote)
                        .foregroundStyle(.red)
                        .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(Color.secondary.quinary)
                .clipShape(RoundedRectangle(cornerRadius: 12.0))
                .listRowSeparator(.hidden)
            }
            .listRowSeparator(.hidden)
            .searchable(text: $viewModel.searchText)
            .listStyle(PlainListStyle())
            .navigationTitle("Launches")
        }
        }
    }
}

#Preview {
    LaunchesView()
}
