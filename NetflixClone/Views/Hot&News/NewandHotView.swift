

//latest update 26/2/25
//
//  Created by Tahsin 
//

import SwiftUI

struct NewandHotView: View {
    @ObservedObject var viewModel = HomeViewModel()
    
    @State private var searchText = ""
    @State private var isSearching = false
    @State private var selectedCategory = "Coming Soon"
    @State private var scrollOffset: CGFloat = 0
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                
                // 1) Single blurred background behind everything
                if let movie = viewModel.trendingMovies.first {
                    AsyncImage(url: movie.backdropURL) { image in
                        image.resizable()
                            .scaledToFill()
                            .frame(width: UIScreen.main.bounds.width,
                                   height: UIScreen.main.bounds.height)
                            .blur(radius: 50)  // Adjust the blur as needed
                            .ignoresSafeArea()
                    } placeholder: {
                        Color.black
                            .ignoresSafeArea()
                    }
                } else {
                    Color.black.ignoresSafeArea()
                }
                
                // 2) Dark overlay if you want dynamic darkness on scroll
                Color.black
                    .opacity(min(0.5, scrollOffset / 300))
                    .ignoresSafeArea()
                
                // 3) Main content in a VStack
                VStack(spacing: 0) {
                    
                    // 3a) Navbar area (blur + nav + categories)
                    ZStack {
                        // Transparent blur matches the background
                        TransparentBlurView()
                            .frame(height: 120)
                            .opacity(scrollOffset > 20 ? min(1, scrollOffset / 150) : 0)
                        
                        VStack(spacing: 0) {
                            NetflixNavBar(isSearching: $isSearching)
                                .padding(.top, 50)
                            
                            CategoriesView(selectedCategory: $selectedCategory)
                                .padding(.bottom, 10)
                        }
                    }
                    .zIndex(1)
                    
                    // 3b) The scrollable content
                    ScrollView {
                        GeometryReader { geo in
                            Color.clear
                                .onChange(of: geo.frame(in: .global).minY) { newValue in
                                    scrollOffset = max(0, -newValue)
                                }
                        }
                        .frame(height: 0)
                        
                        // 4) Category-specific content
                        selectedCategoryView()
                            .frame(minHeight: UIScreen.main.bounds.height)
                        // Ensures each category’s view fills at least one screen
                    }
                    .safeAreaInset(edge: .bottom) {
                        // Additional space to avoid bottom overlap
                        Color.clear.frame(height: 20)
                    }
                }
            }
            // Hide default navbar
            .navigationBarHidden(true)
            // Update search results on text change
            .onChange(of: searchText) { newValue in
                viewModel.filterMovies(by: newValue)
            }
        }
    }
    
    // MARK: - Category Selection
    @ViewBuilder
    func selectedCategoryView() -> some View {
        switch selectedCategory {
        case "Coming Soon":
            ComingSoonView()
            
        case "Everyone’s Watching":
            CategoryDetailView(
                title: "🔥 Everyone’s Watching",
                itemTagline: "Trending Movie",
                movies: viewModel.trendingMovies,
                subtitle: nil
            )
            
        case "Top Movies":
            CategoryDetailView(
                title: "🏆 Top Movies",
                itemTagline: "Top Rated Movie",
                movies: viewModel.allTimeBestMovies,
                subtitle: nil
            )
            
        case "Top TV Shows":
            CategoryDetailView(
                title: "📺 Top TV Shows",
                itemTagline: "Top Rated TV Show",
                movies: viewModel.allTimeBestMovies, // or separate array for TV
                subtitle: nil
            )
            
        default:
            // Fallback or do the same as "Coming Soon"
            CategoryDetailView(
                title: "🍿 Coming Soon",
                itemTagline: "Now Playing",
                movies: viewModel.upcomingMovies,
                subtitle: "Now playing in cinemas"
            )
        }
    }
    
}

// MARK: - Preview
struct News: PreviewProvider {
    static var previews: some View {
        NewandHotView()
    }
}
