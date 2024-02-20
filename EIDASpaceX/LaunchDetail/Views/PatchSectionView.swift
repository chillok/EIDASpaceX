import SwiftUI

struct PatchSectionView: View {
    
    var viewModel: LaunchViewViewModel
    
    var body: some View {
        Section {
            VStack(alignment: .center) {
                VStack {
                    if let patch = viewModel.patch, let url = URL(string: patch) {
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
                    
                    Text(viewModel.name)
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
    }
}

#Preview {
    PatchSectionView(viewModel: .init(id: "2133", flightNumber: 2, name: "q3eqe"))
}
