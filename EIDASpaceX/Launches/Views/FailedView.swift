import SwiftUI

struct FailedView: View {
    
    init(reload: @escaping () -> Void) {
        self.reload = reload
    }
    
    var reload: () -> ()
    
    var body: some View {
        VStack {
            Spacer()
            
            Text("Failed to load Launches. Please try again later.")
                .font(.callout)
            
            Button(action: {
                reload()
            }, label: {
                Text("Reload")
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
