
import SwiftUI

struct SettingsView: View {
    @State private var autoplayPreviews = true
    @State private var enableAutoplay = true
    @State private var showNetworkOptions = false //  Toggle for expanding network options
    @State private var selectedQuality = "1080p" // Stores the selected network quality
    
    var body: some View {
        NavigationView {
            VStack(spacing: 10) {
                
                // **Network Quality (Collapsible)**
                VStack(spacing: 0) {
                    Button(action: {
                        withAnimation {
                            showNetworkOptions.toggle()
                        }
                    }) {
                        HStack {
                            Image(systemName: "globe")
                                .foregroundColor(.white)
                            Text("Network Quality")
                                .foregroundColor(.white)
                                .font(.headline)
                            Spacer()
                            Text(selectedQuality) //  Shows selected quality when collapsed
                                .foregroundColor(.gray)
                                .font(.subheadline)
                            Image(systemName: showNetworkOptions ? "chevron.up" : "chevron.right") //  Chevron for collapse
                                .foregroundColor(.gray)
                        }
                        .padding()
                        .background(Color.gray.opacity(0.2)) //  Dark Gray Background
                        .cornerRadius(10)
                    }
                    
                    if showNetworkOptions {
                        VStack(alignment: .leading, spacing: 8) {
                            ForEach(["Auto Select", "360p", "480p", "720p", "1080p"], id: \.self) { quality in
                                Button(action: {
                                    withAnimation {
                                        selectedQuality = quality
                                        showNetworkOptions = false // Collapse after selection
                                    }
                                }) {
                                    Text(quality)
                                        .foregroundColor(.white.opacity(0.8))
                                        .padding(.vertical, 5)
                                }
                            }
                        }
                        .padding()
                        .background(Color.black.opacity(0.9)) // ✅ Matches image
                        .cornerRadius(10)
                        .transition(.opacity) //  Smooth fade-in animation
                    }
                }
                .padding(.horizontal, 16)
                
                // **AutoPay Row**
                SettingsRow(title: "AutoPay", icon: "creditcard.fill")
                
                // **Audio & Subtitles**
                SettingsRow(title: "Audio & Subtitles", icon: "text.bubble.fill", subtitle: "Bangla")
                
                // **Toggle Settings**
                VStack(spacing: 10) {
                    ToggleRow(title: "Autoplay Previews", isOn: $autoplayPreviews)
                    ToggleRow(title: "Enable Autoplay", isOn: $enableAutoplay)
                }
                .padding(.horizontal, 16)
                
                Spacer()
            }
            .navigationBarTitle("Settings", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: SearchView()) {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.white)
                    }
                }
            }
            .background(Color.black.ignoresSafeArea()) //  Full black background
        }
    }
}

// MARK: - **Static Settings Row**
struct SettingsRow: View {
    let title: String
    let icon: String
    var subtitle: String?

    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.white)
            Text(title)
                .foregroundColor(.white)
                .font(.headline)
            
            Spacer()
            
            if let subtitle = subtitle {
                Text(subtitle)
                    .foregroundColor(.gray)
                    .font(.subheadline)
            }
            
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
        .padding(.horizontal, 16)
    }
}

// MARK: - **Toggle Switch Row**
struct ToggleRow: View {
    let title: String
    @Binding var isOn: Bool

    var body: some View {
        HStack {
            Image(systemName: "play.rectangle.fill")
                .foregroundColor(.white)
            Text(title)
                .foregroundColor(.white)
                .font(.headline)
            Spacer()
            Toggle("", isOn: $isOn)
                .toggleStyle(SwitchToggleStyle(tint: .blue)) //  Blue toggle switches
        }
        .padding()
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
    }
}

// MARK: - Preview
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
