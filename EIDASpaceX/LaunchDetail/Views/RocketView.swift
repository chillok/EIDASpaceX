import SwiftUI
import SwiftData

struct RocketView: View {
    
    let id: String
    
    @Query var rockets: [Rocket]
    
    var filteredRocket: Rocket? {
        rockets.first {
            $0.id == id
        }
    }
    
    init(id: String) {
        self.id = id
    }
    
    var body: some View {
        if let rocket = filteredRocket {
            Section {
                VStack {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 0) {
                            ForEach(rocket.images, id: \.self) { image in
                                if let url = URL(string: image) {
                                    AsyncImage(url: url) { image in
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(height: 200)
                                            .cornerRadius(15)
                                            .padding()
                                    } placeholder: {
                                        ProgressView()
                                    }
                                }
                            }
                        }
                    }
                    
                    Text(rocket.name)
                        .font(.title)
                        .fontDesign(.monospaced)
                        .fontWeight(.bold)
                        .foregroundStyle(Color.gray)
                        .padding()
                    
                    Text(rocket.details)
                }
            } header: {
                Text("Rocket")
            }
        }
    }
}

#Preview {
    RocketView(id: "4567")
}
