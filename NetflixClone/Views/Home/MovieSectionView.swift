//
//  MovieSectionView.swift
//  NetflixClone
//
//  Created by Tahsin on 2/19/25.
//

import SwiftUI

struct MovieSectionView: View {
    let title: String
    let movies: [Movie]

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(.horizontal, 15)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(movies) { movie in
                        movieCard(movie: movie)
                            .shadow(radius: 5)
                    }
                }
                .padding(.horizontal, 15)
            }
        }
    }

    @ViewBuilder
    private func movieCard(movie: Movie) -> some View {
        VStack {
            AsyncImage(url: movie.posterURL) { image in
                image.resizable()
                    .scaledToFill()
                    .frame(width: 120, height: 180)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .shadow(radius: 5)
                    .transition(.opacity)
            } placeholder: {
                Color.gray.opacity(0.3)
                    .frame(width: 120, height: 180)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
            }
            
            Text(movie.title)
                .font(.caption)
                .foregroundColor(.white)
                .frame(width: 120)
                .lineLimit(1)
                .padding(.top, 5)
        }
    }
}
