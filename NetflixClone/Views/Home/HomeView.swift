//
//  Created by Tahsin on 2/25/25.
//


import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel = HomeViewModel()
    
    @State private var searchText = ""
    @State private var isSearching = false
    @State private var selectedCategory = "Trending"
    @State private var scrollOffset: CGFloat = 0

    
    @State private var showActionSheet = false

    
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                
                /// Background Image (Blurred) from Header Movie
                if let movie = viewModel.trendingMovies.first {
                    AsyncImage(url: movie.backdropURL) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                            .blur(radius: 90)
                            .ignoresSafeArea()
                    } placeholder: {
                        Color.black.opacity(0.85).ignoresSafeArea()
                    }
                }

                /// Dark Overlay (Becomes Darker on Scroll)
                Color.black
                    .opacity(min(0.5, scrollOffset / 300)) //  Adjusts darkness dynamically
                    .ignoresSafeArea()
                    .zIndex(0) //  Keep this behind the navbar & content
                
                /// Blur Navbar & Netflix Navbar
                ZStack {
                    TransparentBlurView()
                        .frame(height: 100)
                        .opacity(scrollOffset > 20 ? min(1, scrollOffset / 150) : 0)
                    
                    NetflixNavBar(isSearching: $isSearching)
                        .padding(.top, 50)
                }
                .zIndex(1000)

                /// Scrollable Content Area
                ScrollView {
                    GeometryReader { geo in
                        Color.clear
                            .onChange(of: geo.frame(in: .global).minY) { newValue in
                                scrollOffset = max(0, -newValue) //  Ensure positive values
                            }
                    }
                    .frame(height: 0)

                    VStack(spacing: 10) {
                        Spacer()
                        CategoryBarView(selectedCategory: $selectedCategory)
                            .padding(.top, 90)
                        
                        headerView()
                        
                        if searchText.isEmpty {
                            movieSections()
                        } else {
                            searchResultsSection()
                        }
                    }
                    .padding(.bottom, 10)
                }
                .safeAreaInset(edge: .bottom) {
                    Color.clear.frame(height: 20)
                }
            }
            .onChange(of: searchText) { newValue in
                viewModel.filterMovies(by: newValue)
            }
            .ignoresSafeArea(.all, edges: .top)
            .overlay(
                           HomeActionSheetView(show: $showActionSheet) //  Calling the pop-up
                       )
        }
    }

    /// Header Section
    @ViewBuilder
    private func headerView() -> some View {
        if let movie = viewModel.trendingMovies.first {
            ZStack(alignment: .bottom) {
                AsyncImage(url: movie.backdropURL) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: UIScreen.main.bounds.width - 40, height: 450)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.white.opacity(0.2), lineWidth: 1)
                        )
                        .shadow(color: Color.black.opacity(0.5), radius: 10, x: 0, y: 5)
                } placeholder: {
                    Color.gray.opacity(0.3)
                        .frame(width: UIScreen.main.bounds.width - 40, height: 450)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .shadow(color: Color.black.opacity(0.5), radius: 10, x: 0, y: 5)
                }
                .overlay(
                    LinearGradient(
                        gradient: Gradient(colors: [.clear, .black.opacity(0.9)]),
                        startPoint: .center, endPoint: .bottom
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                )

                VStack(spacing: 10) {
                    Text(movie.title)
                        .font(.title)
                        .bold()
                        .foregroundColor(.white)
                    
                    HStack(spacing: 20) {
                        playButton()
                        myListButton()
                    }
                    .padding(.bottom, 20)
                }
                .padding(.bottom, 10)
            }
            .frame(height: 500)
            .padding(.horizontal, 20)
        }
    }

    /// Movie Sections
    @ViewBuilder
    private func movieSections() -> some View {
        MovieSectionView(title: "Trending Movies", movies: viewModel.trendingMovies)
            .padding(.bottom)
        MovieSectionView(title: "All Time Best Movies", movies: viewModel.allTimeBestMovies)
            .padding(.bottom)
        MovieSectionView(title: "Upcoming Movies", movies: viewModel.upcomingMovies)
            .padding(.bottom)
    }

    /// Search Results
    @ViewBuilder
    private func searchResultsSection() -> some View {
        MovieSectionView(title: "Search Results for '\(searchText)'", movies: viewModel.searchResults)
    }

    /// Play Button (Triggers Pop-Up)
        private func playButton() -> some View {
            Button(action: {
                withAnimation {
                    showActionSheet.toggle() // ✅ Show the pop-up when Play is tapped
                }
            }) {
                HStack {
                    Image(systemName: "play.fill")
                    Text("Play")
                }
                .foregroundColor(.white)
                .padding()
                .background(Color.red)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .shadow(radius: 10)
            }
        }

    /// My List Button
    private func myListButton() -> some View {
        Button(action: {}) {
            HStack {
                Image(systemName: "plus")
                Text("My List")
            }
            .foregroundColor(.white)
            .padding()
            .background(Color.gray.opacity(0.7))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(radius: 10)
        }
    }
}

/// Preview
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
