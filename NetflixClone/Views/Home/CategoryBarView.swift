////  CategoryBarView.swift
////  NetflixClone
//
////  Created by Tahsin on 2/25/25.
////
//
//
//
//
//import SwiftUI
//
///// `CategoryBarView` displays a category selection bar with buttons for "TV Shows," "Movies," and a dropdown for "Category."
///// When "Category" is pressed, it opens a full-screen modal with a blurry background, displaying all subcategories as buttons.
//struct CategoryBarView: View {
//    @Binding var selectedCategory: String  // Accept as a binding
//    
//    let viewModel: HomeViewModel
//    
//    @State private var isCategoryExpanded: Bool = false
//    let categories = ["TV Shows", "Movies"]
//    let dropdownTitle = "Category"
//    let categorySubcategories = [
//        "Available for Download",
//        "2024 Netflix Oscars",
//        "Action",
//        "Anime",
//        "Classics",
//        "Comedies",
//        "Crime",
//        "Critics’ Picks",
//        "Documentaries",
//        "Dramas",
//        "European Films",
//        "Family Cozy Time"
//    ]
//    
//    var body: some View {
//        VStack(alignment: .leading) {
//            HStack {
//                ForEach(categories, id: \ .self) { category in
//                    Button(action: {
//                        selectedCategory = category
//                        isCategoryExpanded = false
//                    }) {
//                        Text(category)
//                            .foregroundColor(selectedCategory == category ? .white : .gray)
//                            .padding(.horizontal, 10)
//                            .padding(.vertical, 5)
//                            .background(selectedCategory == category ? Color.red : Color.clear)
//                            .cornerRadius(10)
//                            .overlay(
//                                RoundedRectangle(cornerRadius: 10) //  Border for Category dropdown
//                                    .stroke(Color.gray, lineWidth: 1)
//                            )
//                    }
//                }
//                
//                Button(action: {
//                    withAnimation {
//                        isCategoryExpanded.toggle()
//                    }
//                }) {
//                    HStack {
//                        Text(dropdownTitle)
//                            .foregroundColor(.gray)
//                        
//                        Image(systemName: "chevron.down")
//                            .foregroundColor(.gray)
//                    }
//                    //                    .padding(.horizontal, 10)
//                    //                    .padding(.vertical, 5)
//                    //                    .background(isCategoryExpanded ? Color.red.opacity(0.3) : Color.clear)
//                    //                    .cornerRadius(10)
//                    
//                }
//            }
//            .frame(maxWidth: .infinity)
//            .padding(.vertical, 10)
//            
//        }
//        .fullScreenCover(isPresented: $isCategoryExpanded) {
//            categorySelectionView()
//        }
//    }
//    
//    /// Full-screen modal that displays category subcategories with a blurred background.
//    //    @ViewBuilder
//    //    private func categorySelectionView() -> some View {
//    //        ZStack {
//    //            /// Blurry Background
//    //            Color.black.opacity(0.4)
//    //                .ignoresSafeArea()
//    //                .background(
//    //                    VisualEffectView(effect: UIBlurEffect(style: .dark))
//    //                        .ignoresSafeArea()
//    //                )
//    //
//    //            VStack(spacing: 15) {
//    //                Text("Select a Category")
//    //                    .font(.title2)
//    //                    .fontWeight(.bold)
//    //                    .foregroundColor(.white)
//    //                    .padding(.top, 40)
//    //
//    //                ScrollView {
//    //                    VStack(spacing: 15) {
//    //                        ForEach(categorySubcategories, id: \ .self) { subcategory in
//    //                            Button(action: {
//    //                                selectedCategory = subcategory
//    //                                isCategoryExpanded = false
//    //                            }) {
//    //                                Text(subcategory)
//    //                                    .foregroundColor(.white)
//    //                                    .frame(maxWidth: .infinity)
//    //                                    .padding()
//    ////                                    .background(Color.gray.opacity(0.2))
//    ////                                    .cornerRadius(10)
//    //                            }
//    //                        }
//    //                    }
//    //                    .padding(.horizontal, 20)
//    //                }
//    //
//    //                /// Close button styled as a circular "X" button
//    //                Button(action: {
//    //                    isCategoryExpanded = false
//    //                }) {
//    //                    Image(systemName: "xmark")
//    //                        .foregroundColor(.white)
//    //                        .padding()
//    //                        .background(Color.red)
//    //                        .clipShape(Circle())
//    //                        .shadow(radius: 10)
//    //
//    //
//    //                }
//    //                .padding(.top, 20)
//    //            }
//    //            .frame(maxWidth: .infinity, maxHeight: .infinity)
//    //            .background(Color.black.opacity(0.2))
//    //            .cornerRadius(20)
//    //            .padding(30)
//    //        }
//    //    }
//    //}
//    
//    
//    @ViewBuilder
//    private func categorySelectionView() -> some View {
//        ZStack {
//            /// ✅ Trending Movie Background (Blurred)
//            if let movie = viewModel.trendingMovies.first {
//                AsyncImage(url: movie.backdropURL) { image in
//                    image
//                        .resizable()
//                        .scaledToFill()
//                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
//                        .blur(radius: 90) // ✅ Blurred Background
//                        .ignoresSafeArea()
//                } placeholder: {
//                    Color.black.opacity(0.85).ignoresSafeArea()
//                }
//            }
//            
//            /// ✅ Dark Overlay for Readability
//            Color.black.opacity(0.5)
//                .ignoresSafeArea()
//            
//            VStack(spacing: 15) {
//                Text("Select a Category")
//                    .font(.title2)
//                    .fontWeight(.bold)
//                    .foregroundColor(.white)
//                    .padding(.top, 40)
//                
//                /// ✅ Scrollable List of Subcategories
//                ScrollView {
//                    VStack(spacing: 15) {
//                        ForEach(categorySubcategories, id: \.self) { subcategory in
//                            Button(action: {
//                                selectedCategory = subcategory
//                                isCategoryExpanded = false
//                            }) {
//                                Text(subcategory)
//                                    .foregroundColor(.white)
//                                    .frame(maxWidth: .infinity)
//                                    .padding()
//                                    .background(Color.gray.opacity(0.2))
//                                    .cornerRadius(10)
//                            }
//                        }
//                    }
//                    .padding(.horizontal, 20)
//                }
//                
//                /// ✅ Close Button (Red Circle)
//                Button(action: {
//                    isCategoryExpanded = false
//                }) {
//                    Image(systemName: "xmark")
//                        .foregroundColor(.white)
//                        .padding()
//                        .background(Color.red)
//                        .clipShape(Circle())
//                        .shadow(radius: 10)
//                }
//                .padding(.top, 20)
//            }
//            .frame(maxWidth: .infinity, maxHeight: .infinity)
//            .background(Color.black.opacity(0.2))
//            .cornerRadius(20)
//            .padding(30)
//        }
//    }
//    
//    /// Custom UIViewRepresentable to enable blur effects in SwiftUI.
//    struct VisualEffectView: UIViewRepresentable {
//        var effect: UIVisualEffect?
//        func makeUIView(context: Context) -> UIVisualEffectView {
//            return UIVisualEffectView()
//        }
//        func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
//            uiView.effect = effect
//        }
//    }
//    
//    }



import SwiftUI

struct CategoryBarView: View {
    @Binding var selectedCategory: String
    let viewModel: HomeViewModel // ✅ Accept viewModel from HomeView

    @State private var isCategoryExpanded: Bool = false
    let categories = ["TV Shows", "Movies"]
    let dropdownTitle = "Category"
    let categorySubcategories = [
        "Available for Download",
        "2024 Netflix Oscars",
        "Action",
        "Anime",
        "Classics",
        "Comedies",
        "Crime",
        "Critics’ Picks",
        "Documentaries",
        "Dramas",
        "European Films",
        "Family Cozy Time"
    ]

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                ForEach(categories, id: \.self) { category in
                    Button(action: {
                        selectedCategory = category
                        isCategoryExpanded = false
                    }) {
                        Text(category)
                            .foregroundColor(selectedCategory == category ? .white : .gray)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .background(selectedCategory == category ? Color.red : Color.clear)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray, lineWidth: 1)
                            )
                    }
                }
                
                Button(action: {
                    withAnimation {
                        isCategoryExpanded.toggle()
                    }
                }) {
                    HStack {
                        Text(dropdownTitle)
                            .foregroundColor(.gray)
                        Image(systemName: "chevron.down")
                            .foregroundColor(.gray)
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 10)
        }
        .fullScreenCover(isPresented: $isCategoryExpanded) {
            categorySelectionView() //  Uses the modified function below
        }
    }
    
    /// ✅ Updated categorySelectionView() with the viewModel background
    @ViewBuilder
    private func categorySelectionView() -> some View {
        ZStack {
            /// ✅ Trending Movie Background (Blurred)
            if let movie = viewModel.trendingMovies.first {
                AsyncImage(url: movie.backdropURL) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                        .blur(radius: 90) //  Blurred Background
                        .ignoresSafeArea()
                } placeholder: {
                    Color.black.opacity(0.70).ignoresSafeArea()
                }
            }

            /// ✅ Dark Overlay for Readability
            Color.black.opacity(0.5)
                .ignoresSafeArea()

            VStack(spacing: 15) {
                Text("Select a Category")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.top, 40)
                
                /// ✅ Scrollable List of Subcategories
                ScrollView {
                    VStack(spacing: 15) {
                        ForEach(categorySubcategories, id: \.self) { subcategory in
                            Button(action: {
                                selectedCategory = subcategory
                                isCategoryExpanded = false
                            }) {
                                Text(subcategory)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .padding()
//                                    .background(Color.gray.opacity(0.2))
//                                    .cornerRadius(10)
                                
                            }
                        }
                    }
//                    .padding(.horizontal, 20)
                }
                
                /// ✅ Close Button (Red Circle)
                Button(action: {
                    isCategoryExpanded = false
                }) {
                    Image(systemName: "xmark")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.red)
                        .clipShape(Circle())
                        .shadow(radius: 10)
                }
                .padding(.top, 20)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
//            .background(Color.black.opacity(0.2))
//            .cornerRadius(20)
            .padding(40)
        }
    }
}



