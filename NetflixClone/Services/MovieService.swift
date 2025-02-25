//
//  Created by Tahsin on 2/25/25.
//

import Foundation

class MovieService {
    private let apiKey = "7101fc95cd466400c197b93a04d08c86"
    private let baseURL = "https://api.themoviedb.org/3"

    func fetchMovies(endpoint: String) async throws -> [Movie] {
        let urlString = "\(baseURL)\(endpoint)?api_key=\(apiKey)"
        print(urlString)
        guard let url = URL(string: urlString) else { throw URLError(.badURL) }

        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode(MovieResponse.self, from: data)
        print(response)
        return response.results
    }
}

struct MovieResponse: Decodable {
    let results: [Movie]
}
