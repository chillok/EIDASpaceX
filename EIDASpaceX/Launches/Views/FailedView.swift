import SwiftUI

private struct Constants {
    static let failedText = "Failed to load Launches. Please try again later."
    static let reloadText = "Reload"
}


struct FailedView: View {
    
    init(reload: @escaping () -> Void) {
        self.reload = reload
    }
    
    var reload: () -> ()
    
    var body: some View {
        VStack {
            Spacer()
            
            Text(Constants.failedText)
                .font(.callout)
            
            Button(action: {
                reload()
            }, label: {
                Text(Constants.reloadText)
                            .padding()
                            .foregroundColor(.white)
                            .background(
                                RoundedRectangle(
                                    cornerRadius: 20,
                                    style: .continuous
                                )
                                .fill(Color.accentColor)
                            )
            })
            
            Spacer()
        }
    }
}

#Preview {
    FailedView(reload: {})
}
