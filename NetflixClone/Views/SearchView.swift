//
//  Created by Tahsin on 
//

import SwiftUI

struct SearchView: View {
    @State private var searchText = ""
    @ObservedObject var viewModel = HomeViewModel()
    @Environment(\.dismiss) private var dismiss // Ensures back navigation works

    var body: some View {
        VStack(spacing: 10) {
            searchBar // Search bar at the top

            if searchText.isEmpty {
                Text("Start typing to search for movies...")
                    .foregroundColor(.gray)
                    .padding(.top, 20)
            } else {
                searchResultsSection
            }

            Spacer() // Push content upwards
        }
        .padding(.horizontal)
        .navigationBarHidden(true) // Hides default navigation bar
    }

    private var searchBar: some View {
        HStack {
            Button(action: {
                dismiss() // Goes back to the previous screen
            }) {
                Image(systemName: "chevron.left")
                    .foregroundColor(.white)
                    .padding(.leading, 8)
            }

            TextField("Search movies...", text: $searchText)
                .font(.system(size: 18, weight: .medium))
                .tint(.white)
                .onChange(of: searchText) { newValue in
                    viewModel.filterMovies(by: newValue)
                }
        }
        .padding()
        .background(Color(uiColor: .systemGray3))
        .cornerRadius(8)
    }

    private var searchResultsSection: some View {
        ScrollView {
            VStack(alignment: .leading) {
                ForEach(viewModel.searchResults) { movie in
                    Text(movie.title)
                        .font(.title3)
                        .padding(.vertical, 5)
                }
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
