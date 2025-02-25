//
//  Created by Tahsin on 2/25/25.
//

import SwiftUI

struct ComingSoonView: View {
    @ObservedObject var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text("🍿 Coming Soon")
                        .font(.title.bold())
                        .foregroundColor(.white)
                        .padding(.horizontal)
                        .padding(.top, 10)
                    
                    ForEach(viewModel.upcomingMovies) { movie in
                        movieCard(movie: movie)
                    }
                }
                .padding(.horizontal)
            }
            .background(Color.black.ignoresSafeArea())
            .navigationTitle("")
            .onAppear {
                Task {
                    await viewModel.fetchMovies()
                }
            }
        }
    }
    
    @ViewBuilder
    private func movieCard(movie: Movie) -> some View {
        HStack(alignment: .top, spacing: 10) {
            VStack {
                Text("20")
                    .font(.system(size: 30, weight: .bold))
                    .foregroundColor(.white)
                Text("JUN")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .frame(width: 50)
            
            VStack(alignment: .leading, spacing: 10) {
                AsyncImage(url: movie.posterURL) { image in
                    image.resizable()
                        .scaledToFill()
                        .frame(height: 250)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                } placeholder: {
                    Color.gray.frame(height: 250)
                }
                
                VStack(alignment: .leading, spacing: 5) {
                    Text(movie.title)
                        .font(.title2.bold())
                        .foregroundColor(.white)
                    
                    Text("Now playing in cinemas")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    Text(movie.overview)
                        .font(.body)
                        .foregroundColor(.white)
                        .lineLimit(3)
                    
                    Text("Animation, Family, Comedy, Science Fiction")
                        .font(.footnote)
                        .foregroundColor(.white.opacity(0.7))
                        .padding(.top, 5)
                }
                
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
        }
        .padding(.horizontal, 10)
        .padding(.bottom, 30)
    }
}

struct ComingSoonView_Previews: PreviewProvider {
    static var previews: some View {
        ComingSoonView()
            .preferredColorScheme(.dark)
    }
}
