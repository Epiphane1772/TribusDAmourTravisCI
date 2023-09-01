//
//  AudioPlayerManager.swift
//  TribusDAmour
//
//  Created by Stephane Lefebvre on 2023-08-03.
//  Copyright © 2023 Stephane Lefebvre. All rights reserved.
//

import Foundation
import AVFoundation
import Combine

class AudioPlayerManager: ObservableObject {
    static let shared = AudioPlayerManager()
    var audioPlayer: AVPlayer?
    var playerItem: AVPlayerItem?

    private let playbackPositionsKey = "savedPlaybackPositions"

    @Published var isPlaying: Bool = false
    @Published var currentProgress: Double = 0.0

    private var playbackPositions: [String: Double] = [:]

    private init() {
        setupAudioSession()
        loadPlaybackPositions()
    }

    func playAudioFrom(url: URL) {
        if let currentPlayer = audioPlayer, isPlaying {
            currentPlayer.pause()
            isPlaying = false
            return
        }

        playerItem = AVPlayerItem(url: url)
        
        NotificationCenter.default.addObserver(self, selector: #selector(audioDidFinishPlaying), name: .AVPlayerItemDidPlayToEndTime, object: playerItem)

        audioPlayer = AVPlayer(playerItem: playerItem)
        audioPlayer?.addPeriodicTimeObserver(forInterval: CMTime(seconds: 0.5, preferredTimescale: 600), queue: DispatchQueue.main) { [weak self] time in
            guard let duration = self?.audioPlayer?.currentItem?.duration else { return }
            let progress = time.seconds / duration.seconds
            self?.currentProgress = progress
        }
        audioPlayer?.play()
        isPlaying = true

        if let savedPosition = playbackPositions[url.absoluteString] {
            audioPlayer?.seek(to: CMTime(seconds: savedPosition, preferredTimescale: 600))
        }
    }

    func stopPlayback() {
        savePlaybackPosition(for: playerItem?.asset as? AVURLAsset)
        audioPlayer?.pause()
        audioPlayer = nil
        isPlaying = false
    }

    func rewind(by seconds: Double = 30.0) {
        let currentTime = audioPlayer?.currentTime().seconds ?? 0
        audioPlayer?.seek(to: CMTime(seconds: max(currentTime - seconds, 0), preferredTimescale: 600))
    }

    func forward(by seconds: Double = 30.0) {
        let currentTime = audioPlayer?.currentTime().seconds ?? 0
        let newTime = min(currentTime + seconds, audioPlayer?.currentItem?.duration.seconds ?? 0)
        audioPlayer?.seek(to: CMTime(seconds: newTime, preferredTimescale: 600))
    }

    func seek(to progress: Double) {
        guard let duration = audioPlayer?.currentItem?.duration.seconds else { return }
        let seekTime = progress * duration
        audioPlayer?.seek(to: CMTime(seconds: seekTime, preferredTimescale: 600))
    }

    func savePlaybackPosition(for asset: AVURLAsset?) {
        guard let urlString = asset?.url.absoluteString else { return }
        let currentPosition = audioPlayer?.currentTime().seconds ?? 0
        playbackPositions[urlString] = currentPosition
        UserDefaults.standard.setValue(playbackPositions, forKey: playbackPositionsKey)
    }

    func loadPlaybackPositions() {
        if let savedPositions = UserDefaults.standard.dictionary(forKey: playbackPositionsKey) as? [String: Double] {
            playbackPositions = savedPositions
        }
    }

    func setupAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Failed to set up audio session: \(error)")
        }
    }

    @objc func audioDidFinishPlaying() {
        audioPlayer?.seek(to: CMTime(seconds: -100, preferredTimescale: 600))
        isPlaying = false
    }
}
