////
////  ProfileActionSheetView.swift
////  NetflixClone
////
////  Created by Tahsin on 3/5/25.
////




import SwiftUI

struct ProfileActionSheetView: View {
    @Binding var show: Bool
    @State private var rememberMe = false
    
    var body: some View {
        ZStack {
            if show {
                // **Dark Transparent Background**
                Color.black.opacity(0.5)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        withAnimation {
                            show = false
                        }
                    }
                
                VStack {
                    Spacer() // **Push the action sheet to the bottom**
                    
                    VStack(spacing: 8) {
                        // **Close Button (Top Right)**
                        HStack {
                            Spacer()
                            Button(action: {
                                withAnimation {
                                    show = false
                                }
                            }) {
                                Image(systemName: "xmark.circle.fill") // Close Button
                                    .foregroundColor(.gray)
                                    .imageScale(.large)
                            }
                            .padding()
                        }
                        
                        // **Action Sheet Options**
                        VStack(spacing: 12) {
                            ProfileActionSheetItem(title: "Manage Profile", icon: "pencil")
                            ProfileActionSheetItem(title: "Account Expired", icon: "person.crop.circle")
                            ProfileActionSheetItem(title: "My List", icon: "list.bullet.rectangle")
                        }
                        .padding(.top, -5)
                        
                        // **Remember Me Checkbox**
                        HStack {
                            Button(action: {
                                rememberMe.toggle()
                            }) {
                                Image(systemName: rememberMe ? "checkmark.square.fill" : "square") //  Checkbox Style
                                    .foregroundColor(rememberMe ? .red : .white)
                                    .imageScale(.large)
                            }
                            
                            Text("Remember Me")
                                .foregroundColor(.white)
                                .font(.headline)
                            
                            Spacer()
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 10)
                        
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: UIScreen.main.bounds.height * 0.35) //  Reduce to 30% of the screen height
                    .background(Color.black) //  Light grayish background like the image
                    .cornerRadius(10)
                    .padding(.horizontal, 12)
                    .padding(.bottom, 20)
                    .transition(.move(edge: .bottom))
                }
            }
        }
    }
}

// MARK: - **Profile Action Sheet Item (Updated for Better Spacing)**
struct ProfileActionSheetItem: View {
    let title: String
    let icon: String
    
    var body: some View {
        Button(action: {
            print("\(title) tapped")
        }) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(.white)
                    .imageScale(.medium) //  Slightly smaller icon size
                    .frame(width: 28, alignment: .leading) //  Better spacing
                
                Text(title)
                    .foregroundColor(.white)
                    .font(.system(size: 14, weight: .medium)) //  Correct text size
                
                Spacer()
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 16)
            .frame(maxWidth: .infinity)
            .background(Color.clear) //  No background, clean look like the image
        }
    }
}

// MARK: - Preview
struct ProfileActionSheetView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileActionSheetView(show: .constant(true))
    }
}
