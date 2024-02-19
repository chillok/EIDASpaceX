import SwiftUI

struct CrewView: View {
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack {
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
            .padding()
        }
    }
}

#Preview {
    CrewView()
}
