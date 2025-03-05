////////  ProfileView.swift
////////  NetflixClone
////////
////////  Created by Tahsin on 2/26/25.


import SwiftUI

struct ProfileView: View {
    @State private var showActionSheet = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 15) {
                    
                    // **Profile Section with Background**
                    VStack(alignment: .leading) {
                        HStack {
                            // **Profile Image**
                            Image("profile_picture") //  Replace with actual profile image
                                .resizable()
                                .scaledToFill()
                                .frame(width: 50, height: 50) //  Adjusted size
                                .clipShape(Circle()) //  Rounded Profile Picture
                                .overlay(Circle().stroke(Color.white, lineWidth: 1)) // Thin white border
                            
                            VStack(alignment: .leading, spacing: 2) {
                                Text("Tahsin Bro") //  User Name
                                    .font(.headline)
                                    .foregroundColor(.white)
                                
                                HStack(spacing: 4) {
                                    Text("Active") //  Active status
                                        .foregroundColor(.green)
                                        .font(.subheadline)
                                    
                                    Text("• Expired on 12th Jan 2025") //  Expiration Date
                                        .foregroundColor(.gray)
                                        .font(.subheadline)
                                }
                            }
                            
                            Spacer()
                        }
                        .padding(.horizontal, 16)
                        .padding(.top, 10)
                        
                        // **View Profile Button**
                        Button(action: {
                            print("View Profile tapped")
                        }) {
                            HStack {
                                Text("View profile")
                                    .foregroundColor(.white)
                                    .font(.subheadline)
                                Image(systemName: "arrow.right")
                                    .foregroundColor(.white)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 8)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(8)
                        }
                        .padding(.horizontal, 16)
                        .padding(.top, 8)
                    }
                    .background(Color.gray.opacity(0.2)) //  Matches the card background in the image
                    .cornerRadius(10)
                    .padding(.horizontal, 16)
                    .padding(.top, 10)
                    
                    // **Action Buttons**
                    VStack(spacing: 10) {
                        ProfileButton(title: "Redeem a voucher")
                        ProfileButton(title: "Buy a pack")
                    }
                    .padding(.horizontal, 16)
                    
                    // **My Content Section**
                    VStack(alignment: .leading, spacing: 10) {
                        Text("My Content")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(.horizontal, 16)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10) {
                                MovieThumbnail()
                                MovieThumbnail()
                                MovieThumbnail()
                            }
                            .padding(.horizontal, 16)
                        }
                    }
                    .padding(.top, 5)
                    
                    // **Settings and Logout Buttons**
                    VStack(spacing: 10) {
                        NavigationLink(destination: SettingsView()) {
                            HStack {
                                Image(systemName: "gearshape.fill")
                                    .foregroundColor(.white)
                                    .imageScale(.medium)
                                Text("Settings")
                                    .foregroundColor(.white)
                                    .font(.headline)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.gray)
                            }
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(10)
                        }

                        
                        

                        ProfileButtonWithIcon(title: "Trams & Condition", icon: "doc.text.fill")
                        ProfileButtonWithIcon(title: "Logout", icon: "power")
                    }
                    .padding(.horizontal, 16)
                    
                    Spacer()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.black.ignoresSafeArea())
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("My Binge")
                        .font(.headline)
                        .foregroundColor(.white)
                }
                
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    NavigationLink(destination: SearchView()) {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.white)
                            .imageScale(.large)
                    }
                    
                    Button(action: {
                        withAnimation {
                            showActionSheet.toggle()
                        }
                    }) {
                        Image(systemName: "line.3.horizontal")
                            .foregroundColor(.white)
                            .imageScale(.large)
                    }
                }
            }
            .overlay(
                ProfileActionSheetView(show: $showActionSheet) //  Now calling the separate file
            )
        }
    }
}

// MARK: - Profile Button (Without Icon)
struct ProfileButton: View {
    let title: String
    
    var body: some View {
        Button(action: {}) {
            HStack {
                Text(title)
                    .foregroundColor(.white)
                    .font(.headline)
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
            .padding()
            .background(Color.gray.opacity(0.2))
            .cornerRadius(10)
        }
    }
}

// MARK: - Profile Button (With Icon)
struct ProfileButtonWithIcon: View {
    let title: String
    let icon: String
    
    var body: some View {
        Button(action: {}) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(.white)
                    .imageScale(.medium)
                Text(title)
                    .foregroundColor(.white)
                    .font(.headline)
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
            .padding()
            .background(Color.gray.opacity(0.2))
            .cornerRadius(10)
        }
    }
}

// MARK: - Movie Thumbnail (For My Content Section)
struct MovieThumbnail: View {
    var body: some View {
        Rectangle()
            .fill(Color.gray.opacity(0.5))
            .frame(width: 100, height: 140)
            .cornerRadius(10)
    }
}

// MARK: - Preview
struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
