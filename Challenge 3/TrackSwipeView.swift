//
//  TrackSwipeView.swift
//  Challenge 3
//
//  Created by William Kesuma on 14/05/25.
//

import SwiftUI
import AVFoundation

struct TrackSwipeView: View {
    let tracks: [Track]
    let currentTrack: Track
    @Binding var selection: Int
    
    @State private var player: AVAudioPlayer?
    @State private var isPlaying = false
    @State private var currentTime: TimeInterval = 0
    @State private var duration: TimeInterval = 0
    @State private var timer: Timer?
    @State private var gallerySelection = 0

    
    @State private var isModalPresented = false // <-- NEW STATE for modal sheet
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            Color(.systemGray6)
                .ignoresSafeArea()
            
            VStack(spacing: 16) {
                // Cover Image + About Section
                ZStack {
                    TabView(selection: $selection) {
                        ForEach(0..<tracks.count, id: \.self) { index in
                            VStack(spacing: 0) {
                                // Cover Image
                                Image(tracks[index].imageName)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: UIScreen.main.bounds.width * 0.9, height: 200)
                                    .clipped()
                                    .cornerRadius(12, corners: [.topLeft, .topRight])
                                
                                // About Section
                                VStack(alignment: .leading, spacing: 8) {
                                    HStack {
                                        VStack(spacing: 8) {
                                            Text(tracks[index].title)
                                                .font(.title)
                                                .bold()
                                                .foregroundColor(.primary)
                                                .multilineTextAlignment(.leading)
                                        }
                                        Spacer()
                                        
                                        Button {
                                            isModalPresented = true
                                        } label: {
                                            Image(systemName: "arrow.up.left.and.arrow.down.right")
                                                .foregroundColor(.primary)
                                                .imageScale(.medium)
                                        }
                                    }
                                    
                                    ForEach(tracks[index].About.components(separatedBy: "\n"), id: \.self) { line in
                                        Text(line)
                                            .font(.body)
                                            .foregroundColor(.primary)
                                            .lineSpacing(5)
                                            .opacity(0.8)
                                    }
                                }
                                .padding(20)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color("BackgroundColor").opacity(0.9))
                                    .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                            )
                            .padding(.horizontal, 8)
                            .padding(.top, 40)
                            .tag(index) // important for TabView selection binding
                        }
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    .frame(height: 400)
                }
                
                // Player Controls
                VStack(spacing: 20) {
                    Slider(value: Binding(
                        get: { currentTime },
                        set: { newVal in
                            currentTime = newVal
                            player?.currentTime = newVal
                        }
                    ), in: 0...duration)
                    .accentColor(.black)
                    .padding(.horizontal, 20)
                    
                    HStack {
                        Text(timeString(from: currentTime))
                        Spacer()
                        Text(timeString(from: duration))
                    }
                    .font(.caption)
                    .foregroundColor(.primary.opacity(0.6))
                    .padding(.horizontal, 20)
                    
                    HStack(spacing: 40) {
                        Button {
                            if selection > 0 { selection -= 1 }
                        } label: {
                            Image(systemName: "backward.fill")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.pink)
                        }
                        
                        Button {
                            togglePlayback()
                        } label: {
                            Image(systemName: isPlaying ? "pause.circle.fill" : "play.circle.fill")
                                .resizable()
                                .frame(width: 70, height: 70)
                                .foregroundColor(.pink)
                        }
                        
                        Button {
                            if selection < tracks.count - 1 { selection += 1 }
                        } label: {
                            Image(systemName: "forward.fill")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.pink)
                        }
                    }
                }
                .padding(.top, 20)
                .padding(.bottom, 10)
                
                Spacer()
            }
            .padding(.horizontal, 16)
        }
        .onAppear {
            if let idx = tracks.firstIndex(where: { $0.id == currentTrack.id }) {
                selection = idx
                playSong(named: tracks[idx].songFile)
            }
        }
        .onChange(of: selection) { newValue in
            stopSong()
            playSong(named: tracks[newValue].songFile)
            gallerySelection = 0
        }
        // Modal Sheet Presentation
        .sheet(isPresented: $isModalPresented) {
            NavigationStack {
                VStack(spacing: 0) {
                    
                    // === Drag Indicator ===
                    Capsule()
                        .fill(Color.secondary.opacity(0.4))
                        .frame(width: 40, height: 5)
                        .padding(.top, 10)
                    
                    // === Custom Big NavBar Header ===
                    VStack(alignment: .center, spacing: 4) {
                        Text(tracks[selection].title)
                            .font(.system(size: 28, weight: .bold, design: .rounded))
                            .foregroundColor(.primary)
                        
                        Text(tracks[selection].artist2)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding(.top, 10) // Space below indicator
                    .padding(.bottom, 10)
                    
                    Divider() // Nav bar separator
                    
                    // === Main Content ===
                    ScrollView {
                        VStack(alignment: .leading, spacing: 20) {
                            if selection < tracks.count {
                                let currentTrack = tracks[selection]
                                VStack(alignment: .leading, spacing: 10) {
                                    Text(currentTrack.galleryTitle[gallerySelection])
                                        .font(.title3)
                                        .fontWeight(.bold)
                                        .foregroundColor(.pink)
                                        .padding(.horizontal, 10)
                                }
                                .padding(.horizontal)
                                .padding(.top, 10)
                                
                                // Swipeable Gallery Images
                                GeometryReader { geometry in
                                    TabView(selection: $gallerySelection) {
                                        ForEach(Array(currentTrack.galleryImages.enumerated()), id: \.offset) { index, imageName in
                                            Image(imageName)
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: geometry.size.width * 0.9, height: 250)
                                                .clipped()
                                                .cornerRadius(15)
                                                .tag(index)
                                        }
                                    }
                                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                                    .tint(.pink)
                                }
                                .frame(height: 250) // Adjusted to match image height exactly

                                // About Section
                                VStack(alignment: .leading, spacing: 10) {
                                    Text("About")
                                        .font(.headline)
                                        .foregroundColor(.pink)
                                        .padding(.horizontal, 10)
                                    
                                    Text(currentTrack.About2)
                                        .font(.body)
                                        .foregroundColor(.primary)
                                        .lineSpacing(5)
                                        .padding(10)
                                }
                                .padding(.horizontal)
                                
                            } else {
                                Text("Invalid Track")
                                    .font(.title)
                                    .foregroundColor(.red)
                            }
                        }
                    }
                }
                .presentationDetents([.large])
            }
        }
    }
    
    // Audio Helpers
    private func playSong(named name: String) {
        guard let url = Bundle.main.url(forResource: name, withExtension: nil) else {
            print("Song file not found: \(name)")
            return
        }
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.prepareToPlay()
            player?.play()
            duration = player?.duration ?? 0
            isPlaying = true
            currentTime = 0
            startTimer()
        } catch {
            print("Audio error: \(error.localizedDescription)")
        }
    }
    
    private func stopSong() {
        player?.stop()
        isPlaying = false
        timer?.invalidate()
        currentTime = 0
    }
    
    private func togglePlayback() {
        guard let player = player else { return }
        if player.isPlaying {
            player.pause()
            isPlaying = false
            timer?.invalidate()
        } else {
            player.play()
            isPlaying = true
            startTimer()
        }
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
            currentTime = player?.currentTime ?? 0
        }
    }
    
    private func timeString(from time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%d:%02d", minutes, seconds)
    }
}

#Preview {
    TrackSwipeView(
        tracks: [
            Track(
            title: "Track 1",
            artist: "Artist 1",
            artist2: "Artist 2",
            imageName: "GrayBox",
            galleryImages: ["test", "test"],
            galleryTitle: ["Title Gallery", "Title Gallery 2"],
            songFile: "Red",
            About: "About",
            About2: "About 2"
        )
        ],
        currentTrack: Track(
        title: "Track 1",
        artist: "Artist 1",
        artist2: "Artist 2",
        imageName: "Image 1",
        galleryImages: ["test", "test"],
        galleryTitle: ["Title Gallery", "Title Gallery 2"],
        songFile: "Red",
        About: "About",
        About2: "About 2"
    ),
        selection: .constant(0))
}
