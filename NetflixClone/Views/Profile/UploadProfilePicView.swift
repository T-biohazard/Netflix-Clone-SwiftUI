//
//  UploadProfilePicView.swift
//  NetflixClone
//
//  Created by SD3 on 2/26/25.

//
//-------------Not Used ------------

import SwiftUI
import PhotosUI
import AVFoundation

struct UploadImageView: View {
    @State private var selectedImage: Image? = Image(systemName: "person.crop.circle.fill")
    @State private var showUploadView = false
    
    var body: some View {
        VStack {
            selectedImage?
                .resizable()
                .scaledToFit()
                .frame(width: 160, height: 160)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.blue, lineWidth: 3))
                .shadow(radius: 5)
                .onTapGesture {
                    showUploadView = true
                    UIImpactFeedbackGenerator(style: .light).impactOccurred()
                }
                .padding()
            
            Text("Tap to change profile picture")
                .font(.headline)
                .foregroundColor(.gray.opacity(0.8))
                .padding(.top, 5)
        }
        .sheet(isPresented: $showUploadView) {
            ImageUploadView(selectedImage: $selectedImage)
        }
        .animation(.easeInOut(duration: 0.3), value: showUploadView)
    }
}

struct ImageUploadView: View {
    @Binding var selectedImage: Image?
    @State private var tempUIImage: UIImage?
    
    var body: some View {
        NavigationView {
            VStack {
                TabView {
//                    CameraView(image: $tempUIImage)
//                        .tabItem { Label("📷 Camera", systemImage: "camera.fill") }
//                    
////                    GalleryView(image: $tempUIImage)
//                        .tabItem { Label("🖼 Gallery", systemImage: "photo.fill") }
                }
                .tabViewStyle(DefaultTabViewStyle())
                
                if let tempUIImage = tempUIImage {
                    Image(uiImage: tempUIImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 220, height: 220)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .shadow(radius: 10)
                        .padding()
                        .transition(.opacity)
                }
                
                Button(action: {
                    if let uiImage = tempUIImage {
                        selectedImage = Image(uiImage: uiImage)
                        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                    }
                }) {
                    Text("Confirm Selection")
                        .frame(width: 200, height: 50)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .font(.title2)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .shadow(radius: 5)
                        .padding(.top, 10)
                }
            }
            .navigationTitle("Upload Image")
        }
    }
}

struct UploadImageView_Previews: PreviewProvider {
    static var previews: some View {
        UploadImageView()
    }
}
