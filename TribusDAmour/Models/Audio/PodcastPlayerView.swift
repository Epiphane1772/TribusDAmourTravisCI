//
//  PodcastPlayerView.swift
//  TribusDAmour
//
//  Created by Stephane Lefebvre on 2023/08/20.
//  Copyright © 2023 SEL Consulting. All rights reserved.
//

import SwiftUI
import AVKit

class PodcastPlayerManager: ObservableObject {
    @Published var playbackTime: String = "00:00"
    var player: AVPlayer? {
        didSet {
            observePlaybackTime()
        }
    }

    private var timeObserverToken: Any?

    init(url: URL) {
        self.player = AVPlayer(url: url)
    }

    private func observePlaybackTime() {
        guard let player = player else { return }
        let interval = CMTime(seconds: 1, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        timeObserverToken = player.addPeriodicTimeObserver(forInterval: interval, queue: .main) { [weak self] time in
            let totalSeconds = Int(time.seconds)
            let minutes = totalSeconds / 60
            let seconds = totalSeconds % 60
            self?.playbackTime = String(format: "%02d:%02d", minutes, seconds)
        }
    }

    func play() {
        player?.play()
    }

    deinit {
        if let token = timeObserverToken {
            player?.removeTimeObserver(token)
        }
    }
}

struct PodcastPlayerView: View {
    @ObservedObject var playerManager: PodcastPlayerManager

    var body: some View {
        VStack {
            // This is the label for displaying playback time.
            Text(playerManager.playbackTime)
                .font(.system(size: 16, weight: .medium))
                .accessibility(identifier: "playbackTimeLabelAccessibilityIdentifier")
                .accessibility(label: Text("Playback time"))

            // Add other UI components for your player here, such as play, pause buttons.
            Button("Play") {
                playerManager.play()
            }
        }
    }
}
