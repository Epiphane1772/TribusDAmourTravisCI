//
//  PodcastDetailView.swift
//  TribusDAmour
//
//  Created by Lab Comments: Stephane Lefebvre on 8/27/23.
//  Copyright © Lab Comments: 2023 SEL Consulting. All rights reserved.
//

import SwiftUI
import Kingfisher
import AVFoundation
import AVKit

enum ActiveSheet: Identifiable {
    case player, share
    var id: Int {
        switch self {
        case .player: return 1
        case .share: return 2
        }
    }
}

struct ShareSheet: UIViewControllerRepresentable {
    var items: [Any]
    func makeUIViewController(context: Context) -> UIActivityViewController { return UIActivityViewController(activityItems: items, applicationActivities: nil) }
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}

struct PodcastDetailView: View {
    let podcast: PodcastData
    @Environment(\.managedObjectContext) var moc
    @State private var isFavorite: Bool = false
    @State private var activeSheet: ActiveSheet?
    @ObservedObject var audioManager = AudioPlayerManager.shared
    @AppStorage("voiceHints") private var voiceHints = true
    let speechSynthesizer = AVSpeechSynthesizer()
    @State private var podcastArtwork: UIImage?
    private var podcastManager: PodcastCoreDataManager {
        PodcastCoreDataManager(context: moc)
    }
    @State private var showPlayButton: Bool = true
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 20) {
                KFImage(URL(string: podcast.imageUrl))
                    .placeholder {
                        Image(systemName: "photo.fill")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.gray)
                            .frame(width: 200, height: 200)
                    }
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(10)
                HStack {
                    if showPlayButton {
                        Button(action: {
                            self.activeSheet = .player
                            showPlayButton.toggle()
                        }) {
                            Image(systemName: "play.circle.fill")
                                .resizable()
                                .frame(width: 60, height: 60)
                        }
                    } else {
                        Button(action: {
                            if let player = PlayerManager.shared.player {
                                if player.timeControlStatus == .playing { player.pause() }
                                else { player.play() }
                            }
                            showPlayButton.toggle()
                        }) {
                            Image(systemName: "pause.circle.fill")
                                .resizable()
                                .frame(width: 60, height: 60)
                        }
                    }
                }
                Text(podcast.author)
                    .font(.title2)
                    .foregroundColor(.secondary)
                if !podcast.description.isEmpty {
                    Text(podcast.description)
                        .font(.body)
                        .multilineTextAlignment(.leading)
                        .lineLimit(nil)
                        .padding(.top, 10)
                } else {
                    Text("Description not available")
                        .font(.body)
                        .foregroundColor(.secondary)
                        .padding(.top, 10)
                }
            }
            .padding()
        }
        .navigationTitle("Podcast Details")
        .navigationBarItems(trailing:
            Button(action: {
                toggleFavorites()
            }) {
                Image(systemName: isFavorite ? "heart.fill" : "heart")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundColor(isFavorite ? .green : .red)
            }
        )
        .onAppear {
            checkIfFavorite()
            if voiceHints {
                announceDescription()
            }
        }
        .sheet(item: $activeSheet) { item in
            switch item {
            case .player:
                VStack {
                    if let image = KingfisherManager.shared.cache.retrieveImageInMemoryCache(forKey: self.podcast.imageUrl) {
                        AVPlayerViewControllerWrapper(url: URL(string: self.podcast.audioUrl)!, image: image)
                    } else {
                        AVPlayerViewControllerWrapper(url: URL(string: self.podcast.audioUrl)!, image: nil)
                    }
                    Button(action: {
                        self.activeSheet = .share
                    }) {
                        Image(systemName: "square.and.arrow.up")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                            .padding()
                    }
                }
            case .share:
                ShareSheet(items: [self.podcast.audioUrl])
            }
        }
    }
    
    func checkIfFavorite() {
        isFavorite = podcastManager.exists(podcastData: podcast)
    }

    func toggleFavorites() {
        if isFavorite {
            podcastManager.remove(podcastData: podcast)
            isFavorite = false
        } else {
            podcastManager.add(podcastData: podcast)
            isFavorite = true
        }
        do {
            try moc.save()
        } catch {
            print("Error saving managed object context: \(error)")
        }
    }

    func announceDescription() {
        let utteranceText = !podcast.description.isEmpty ? podcast.description : "Description non disponible"
        let utterance = AVSpeechUtterance(string: utteranceText)
        utterance.voice = AVSpeechSynthesisVoice(language: "fr-FR")
        utterance.volume = 1.0
        speechSynthesizer.speak(utterance)
    }
}
