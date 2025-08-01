import SwiftUI
import AVFoundation

struct ContentView: View {
    @State private var selection: Int = 0
    @State private var audioPlayer: AVAudioPlayer?
    @State private var currentlyPlayingID: UUID?
    @State private var gallerySelection = 0

    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemGray6)
                    .ignoresSafeArea()
                
                ScrollView {
                    Image("Born2")
                        .resizable()
                        .frame(width: 250, height: 250)
                        .opacity(0.9)
                        .offset(y: -9)
                        .padding(.top, 20)
                    
                    VStack(alignment: .center, spacing: 8) {
                        Text("🎧 Felicia's Playlist 🎧 ")
                            .font(.largeTitle).bold()
                            .foregroundColor(.primary)
                        
                        Text("Made by Wilkez")
                            .font(.body)
                            .foregroundColor(.secondary)
                        
                    }
                    .padding(.bottom, 30)
                    
                    // Track Box
                    VStack(spacing: 16) { // <<-- Add spacing here
                        ForEach(tracks) { track in
                            HStack(spacing: 16) {
                                NavigationLink(destination: TrackSwipeView(tracks: tracks, currentTrack: track, selection: $selection)) {
                                    HStack(spacing: 16) {
                                        Image(track.imageName)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 80, height: 80)
                                            .cornerRadius(10)
                                        
                                        VStack(alignment: .leading) {
                                            Text(track.title)
                                                .font(.headline)
                                                .foregroundColor(.primary)
                                            Text(track.artist)
                                                .font(.caption)
                                                .foregroundColor(.secondary)
                                        }
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    }
                                }
                                
                                // Play / Pause Button
                                Button(action: {
                                    // Toggle play/pause action here
                                }) {
                                    Image(systemName: (currentlyPlayingID == track.id) ? "pause.circle.fill" : "play.circle.fill")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 30, height: 30)
                                        .foregroundColor(.pink)
                                        .background(Color.white)
                                        .clipShape(Circle())
                                }
                            }
                            .padding()
                            .background(Color.pink.opacity(0.1))
                            .cornerRadius(16)
                        }
                    }
                }
                .scrollIndicators(.hidden)
                .padding(.horizontal)
            }
        }
        .tint(.pink)
    }
    
    // MARK: - Audio Playback Function
    private func playPreview(for track: Track) {
        if currentlyPlayingID == track.id {
            audioPlayer?.stop()
            audioPlayer = nil
            currentlyPlayingID = nil
            return
        }
        
        if let url = Bundle.main.url(forResource: track.songFile, withExtension: nil) {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.play()
                currentlyPlayingID = track.id
            } catch {
                print("Playback error: \(error.localizedDescription)")
            }
        } else {
            print("File not found: \(track.songFile)")
        }
    }
}


// MARK: - Rounded Corner Extension
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

#Preview {
    ContentView()
}
