//
//  Created by Tahsin on 2/25/25.
//
import SwiftUI

struct NetflixNavBar: View {
    @Binding var isSearching: Bool

    var body: some View {
        HStack {
            // Dynamic user login
            Text("For Tahsin")
                .font(.title2)
                .bold()
                .foregroundColor(.white)

            Spacer()

            NavigationLink(destination: SearchView()) {
                Image(systemName: "magnifyingglass")
                    .font(.title2)
                    .foregroundColor(.white)
            }
        }
        .padding(.horizontal)
        
        .frame(height: 50) // Adjust navbar height to avoid taking too much space
//        .background(
//            BlurView(style: .systemUltraThinMaterialDark) // Apply blur effect
//                .edgesIgnoringSafeArea(.top) // Make sure it extends to the top of the screen
//        )
        .background(LinearGradient(gradient: Gradient(colors: [.clear, .clear]), startPoint: .top, endPoint: .bottom))
        .shadow(radius: 10) // Shadow effect
        .navigationBarHidden(true) // Hide the default navigation bar
    }
}

// MARK: - Preview
struct NetflixNavBar_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black.ignoresSafeArea() // Simulating dark mode
            ScrollView {
                VStack {
                    NetflixNavBar(isSearching: .constant(false))
                        .zIndex(1) // Ensure it stays on top of the scrollable content
                    // Your content here (e.g., ScrollView or other views)
                }
            }
        }
    }
}



