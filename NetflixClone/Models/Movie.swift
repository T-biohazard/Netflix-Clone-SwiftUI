//
//  Movie.swift
//  NetflixClone
//
//  Created by Tahsin on 2/9/25.
//represent movies fetched from TMDB.
import Foundation

struct Movie: Identifiable, Decodable {
    let id: Int
    let title: String
    let overview: String
    let posterPath: String?
    let backdropPath: String?

    var posterURL: URL? {
        guard let path = posterPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w500\(path)")
    }
    
    var backdropURL: URL? {
        guard let path = backdropPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w780\(path)")
    }
    
    enum CodingKeys: String, CodingKey{
        case id, title, overview
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
    }
}
