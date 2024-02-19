import SwiftUI

struct LoadingView: View {
      @State var degreesRotating = 0.0
    
      var body: some View {
        
          Text("🚀")
              .font(.largeTitle)
              .rotationEffect(.degrees(degreesRotating))
              .onAppear {
                  withAnimation(.linear(duration: 1)
                    .speed(0.5).repeatForever(autoreverses: false)) {
                      degreesRotating = 360.0
                  }
              }
    }
}

#Preview {
    LoadingView()
}
