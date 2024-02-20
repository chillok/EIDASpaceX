import SwiftUI

struct CrewCellView: View {
    
    @ObservedObject var member: CrewMember
    
    var body: some View {
        VStack {
            if let image = URL(string: member.image) {
                AsyncImage(url: image) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                } placeholder: {
                    ProgressView().progressViewStyle(.circular)
                }
            }
            
            Text(member.name)
                .font(.caption)
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)
            
            Spacer()
        }
    }
}

#Preview {
    CrewCellView(member: CrewMember.init(id: "", name: "name", image: ""))
}
