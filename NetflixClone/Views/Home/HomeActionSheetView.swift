
import SwiftUI

struct HomeActionSheetView: View {
    @Binding var show: Bool
    
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
                        // **Close Button & Title (Top Row)**
                        HStack {
                            Text("Selected Movie Title ") // Movie Title
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.white)
                                .padding(.leading, 16)
                            
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
                        
                        Divider().background(Color.gray.opacity(0.3)) // Light gray divider
                        
                        // **Action Sheet Options**
                        VStack(spacing: 12) {
                            HomeActionSheetItem(title: "Episodes And Info", icon: "info.circle")
                            HomeActionSheetItem(title: "Download Next Episode", icon: "arrow.down.to.line.alt")
                            HomeActionSheetItem(title: "Not For Me", icon: "hand.thumbsdown")
                            HomeActionSheetItem(title: "I Like It", icon: "hand.thumbsup")
                            HomeActionSheetItem(title: "Remind Me", icon: "bell")
                            HomeActionSheetItem(title: "Remove From Row", icon: "xmark")
                        }
                        .padding(.top, 5)
                        
                        Divider().background(Color.gray.opacity(0.3)) //  Bottom separator
                        
                        // **Drag Indicator at Bottom**
                        RoundedRectangle(cornerRadius: 3)
                            .frame(width: 40, height: 5)
                            .foregroundColor(.white.opacity(0.3))
                            .padding(.bottom, 10)
                        
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: UIScreen.main.bounds.height * 0.55) // 35% of screen height
                    .background(Color.black) //  Full black background
                    .cornerRadius(5)
//                    .padding(.horizontal, 2)
                    .padding(.bottom, 30)
                    .transition(.move(edge: .bottom))
                }
            }
        }
    }
}

// MARK: - **Home Action Sheet Item (Updated for Better Spacing)**
struct HomeActionSheetItem: View {
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
                    .frame(width: 28, alignment: .leading) // Better spacing
                
                Text(title)
                    .foregroundColor(.white)
                    .font(.system(size: 14, weight: .medium)) //  Correct text size
                
                Spacer()
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 16)
            .frame(maxWidth: .infinity)
            .background(Color.gray.opacity(0.2)) //  Softer background
            .cornerRadius(8)
            .padding(.horizontal, 16)
        }
    }
}

// MARK: - Preview
struct HomeActionSheetView_Previews: PreviewProvider {
    static var previews: some View {
        HomeActionSheetView(show: .constant(true))
    }
}
