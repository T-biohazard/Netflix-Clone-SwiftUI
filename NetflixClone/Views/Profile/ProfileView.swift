////  ProfileView.swift
////  NetflixClone
////
////  Created by Tahsin on 2/26/25.
////
////


import SwiftUI

struct ProfileView: View {
    @State private var showActionSheet = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 10) {
                    // Profile Section
                    VStack {
                        Image(systemName: "person.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                            .foregroundColor(.white)
                            .clipShape(Circle())
                            .padding(.top, 20)
                        
                        Text("Tahsin Bro")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        
                        Text("Account Status: Active")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .padding(.bottom, 10)
                    
                    // Action Buttons
                    VStack(spacing: 10) {
                        ProfileButton(title: "Redeem a voucher")
                        ProfileButton(title: "Buy a pack")
                    }
                    .padding(.horizontal)
                    
                    // My Content Section
                    VStack(alignment: .leading) {
                        Text("My Content")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(.leading, 20)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10) {
                                MovieThumbnail()
                                MovieThumbnail()
                                MovieThumbnail()
                            }
                            .padding(.horizontal)
                        }
                    }
                    
                    // Settings and Logout Buttons
                    VStack(spacing: 10) {
                        ProfileButton(title: "Settings")
                        ProfileButton(title: "Trams & Condition")
                        ProfileButton(title: "Logout")
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
                       .background(Color.black.ignoresSafeArea())
                       .navigationBarTitleDisplayMode(.inline) // Keeps title layout inline
                       .toolbar {
                           ToolbarItem(placement: .navigationBarLeading) {
                               Text("My Binge") // ✅ Left-aligned title
                                   .font(.headline)
                                   .foregroundColor(.white)
                           }
                           
                           ToolbarItemGroup(placement: .navigationBarTrailing) {
                               NavigationLink(destination: SearchView()) { // ✅ Search Button
                                   Image(systemName: "magnifyingglass")
                                       .foregroundColor(.white)
                                       .imageScale(.large)
                               }
                               
                               Button(action: {
                                   withAnimation {
                                       showActionSheet.toggle()
                                   }
                               }) { // ✅ Menu Button
                                   Image(systemName: "line.3.horizontal")
                                       .foregroundColor(.white)
                                       .imageScale(.large)
                               }
                           }
                       }
                       .overlay(
                           CustomActionSheet(show: $showActionSheet)
                       )
                   }
               }
           }

// MARK: - Custom Action Sheet (Half Screen)
struct CustomActionSheet: View {
    @Binding var show: Bool
    @State private var rememberMe = false
    
    var body: some View {
        ZStack {
            if show {
                // Background Overlay
                Color.black.opacity(0.5)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        withAnimation {
                            show = false
                        }
                    }
                
                VStack {
                    Spacer() // Pushes the sheet to the bottom
                    
                    VStack {
                        // Close Button (X at the top-right)
                        HStack {
                            Spacer()
                            Button(action: {
                                withAnimation {
                                    show = false
                                }
                            }) {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.gray)
                                    .imageScale(.large)
                            }
                            .padding()
                        }
                        
                        // Action Sheet Options
                        VStack(spacing: 15) {
                            ActionSheetItem(title: "Manage Profile", icon: "pencil")
                            ActionSheetItem(title: "Account Expired", icon: "exclamationmark.triangle")
                            ActionSheetItem(title: "My List", icon: "list.bullet")
                        }
                        .padding(.top, -10)
                        
                        // Toggle (Remember Me)
                        Toggle(isOn: $rememberMe) {
                            Text("Remember Me")
                                .foregroundColor(.white)
                        }
                        .toggleStyle(SwitchToggleStyle(tint: .red))
                        .padding(.horizontal, 20)
                        .padding(.top, 15)
                        
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: UIScreen.main.bounds.height * 0.4) // Half of the screen height
                    .background(Color.black)
                    .cornerRadius(20)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 20)
                    .transition(.move(edge: .bottom))
                }
            }
        }
    }
}

// MARK: - Action Sheet Item
struct ActionSheetItem: View {
    let title: String
    let icon: String
    
    var body: some View {
        Button(action: {
            print("\(title) tapped")
        }) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(.white)
                    .imageScale(.large)
                    .frame(width: 25, alignment: .leading) // Ensures proper alignment
                
                Text(title)
                    .foregroundColor(.white)
                    .font(.headline)
                
                Spacer()
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.gray.opacity(0.2))
            .cornerRadius(10)
            .padding(.horizontal, 20)
        }
    }
}

// MARK: - Reusable Components
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
