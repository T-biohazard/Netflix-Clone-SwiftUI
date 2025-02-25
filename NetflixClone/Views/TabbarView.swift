//
//  Created by Tahsin on 2/25/25.
//

import SwiftUI

struct TabBarView: View {
    @State private var selectedTab = 0
    @State private var isSearching = false

    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationView {
                VStack {
                   
                    HomeView()
                }
            }
            .tabItem {
                Image(systemName: "house.fill")
                Text("Home")
            }
            .tag(0)

            // Commented out the Search tab
            /*
            NavigationStack {
                VStack {
                    NetflixNavBar(isSearching: $isSearching)
                    SearchView()
                }
            }
            .tabItem {
                Image(systemName: "magnifyingglass")
                Text("Search")
            }
            .tag(1)
            */

            NavigationView {
                VStack {
                   
                    NewandHotView()
                }
            }
                .tabItem {
                    Image(systemName: "play.rectangle")
                    Text("New & Hot")
                }
                .tag(2)

            Text("Downloads")
                .tabItem {
                    Image(systemName: "arrow.down.to.line.alt")
                    Text("Downloads")
                }
                .tag(3)
        }
        .accentColor(.red)
        .background(BlurView(style: .systemUltraThinMaterialDark)) // Blurred Background
    }
}

// MARK: - Blurred Background View
struct BlurView: UIViewRepresentable {
    var style: UIBlurEffect.Style

    func makeUIView(context: Context) -> UIVisualEffectView {
        UIVisualEffectView(effect: UIBlurEffect(style: style))
    }

    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {}
}

// MARK: - Preview
struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
