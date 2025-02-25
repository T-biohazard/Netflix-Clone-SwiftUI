//
//  CategoryDetailView.swift
//  NetflixClone
//
//  Created by Tahsin on 2/25/25.
//

import SwiftUI

struct CategoryDetailView: View {
    /// Title shown at the top (e.g. "🔥 Everyone’s Watching" or "🏆 Top Movies")
    let title: String
    
    /// A short label under the movie description (e.g. "Top Rated Movie", "Trending Movie", etc.)
    /// or you can pass `nil` if not needed
    let itemTagline: String
    
    /// The array of movies to display
    let movies: [Movie]
    
    /// Optional: If you want a second heading, e.g. "Now playing in cinemas"
    let subtitle: String?
    
    // If you still want to fetch data here, keep a ViewModel or remove if data is passed in
    @ObservedObject var viewModel: HomeViewModel = HomeViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // 1) Main Title
                    Text(title)
                        .font(.title.bold())
                        .foregroundColor(.white)
                        .padding(.horizontal)
                        .padding(.top, 10)
                    
                    // 2) Loop through the movies array
                    ForEach(movies) { movie in
                        movieCard(movie: movie)
                    }
                }
                .padding(.horizontal)
            }
            .background(Color.black.ignoresSafeArea())
            .navigationTitle("") // Hide default title
            .onAppear {
                // If you want to re-fetch data, do it here
                // or remove if data is already loaded before passing in
                Task {
                    await viewModel.fetchMovies()
                }
            }
        }
    }
    
    // MARK: - Movie Card Layout
    @ViewBuilder
    private func movieCard(movie: Movie) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            
            // Movie Poster
            AsyncImage(url: movie.posterURL) { image in
                image.resizable()
                    .scaledToFill()
                    .frame(height: 250)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            } placeholder: {
                Color.gray.frame(height: 250)
            }
            
            // Text Info
            VStack(alignment: .leading, spacing: 5) {
                Text(movie.title)
                    .font(.title2.bold())
                    .foregroundColor(.white)
                
                // Optional subtitle: e.g. "Now playing in cinemas"
                if let subtitle = subtitle {
                    Text(subtitle)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                
                Text(movie.overview)
                    .font(.body)
                    .foregroundColor(.white)
                    .lineLimit(3)
                
                // e.g. "Top Rated Movie" / "Trending Movie"
                Text(itemTagline)
                    .font(.footnote)
                    .foregroundColor(.white.opacity(0.7))
                    .padding(.top, 5)
            }
            
            // Buttons
            HStack(spacing: 30) {
                Button(action: {}) {
                    Label("Remind Me", systemImage: "bell")
                        .foregroundColor(.white)
                }
                
                Button(action: {}) {
                    Label("Info", systemImage: "info.circle")
                        .foregroundColor(.white)
                }
            }
            .padding(.top, 5)
        }
        .padding(.horizontal, 10)
        .padding(.bottom, 30)
    }
}

// MARK: - Preview
struct CategoryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryDetailView(
            title: "🏆 Top Movies",
            itemTagline: "Top Rated Movie",
            movies: [
                // Pass some sample Movies
                Movie(id: 1, title: "Sample 1", overview: "Overview 1", posterPath: nil, backdropPath: nil),
                Movie(id: 2, title: "Sample 2", overview: "Overview 2", posterPath: nil, backdropPath: nil)
            ],
            subtitle: "Optional subtitle"
        )
        .preferredColorScheme(.dark)
    }
}
