//
//  Created by Tahsin on 2/25/25.
//

import Foundation

@MainActor
class HomeViewModel: ObservableObject {
    @Published var trendingMovies: [Movie] = []
    @Published var allTimeBestMovies: [Movie] = []
    @Published var upcomingMovies: [Movie] = []
    @Published var searchResults: [Movie] = []
    @Published var isLoading = false
    private let service = MovieService()

    init() {
        Task {
            await fetchMovies()
        }
    }

    func fetchMovies() async {
        isLoading = true
        do {
            // Fetch trending movies
            let trending = try await service.fetchMovies(endpoint: "/trending/movie/week")
            self.trendingMovies = trending

            // Fetch all time best movies (you'll need to adjust the endpoint accordingly)
            let allTimeBest = try await service.fetchMovies(endpoint: "/movie/top_rated")
            self.allTimeBestMovies = allTimeBest

            // Fetch upcoming movies (again, adjust the endpoint as per your API)
            let upcoming = try await service.fetchMovies(endpoint: "/movie/upcoming")
            self.upcomingMovies = upcoming

            // Initialize searchResults with all available movies
            self.searchResults = trending

        } catch {
            print("Error fetching movies:", error.localizedDescription)
        }
        isLoading = false
    }

    func filterMovies(by query: String) {
        if query.isEmpty {
            // Combine all categories into searchResults
            searchResults = trendingMovies + allTimeBestMovies + upcomingMovies
        } else {
            // Filter across all categories
            let allMovies = trendingMovies + allTimeBestMovies + upcomingMovies
            searchResults = allMovies.filter { $0.title.lowercased().contains(query.lowercased()) }
        }
    }
}
