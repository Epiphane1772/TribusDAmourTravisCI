//
//  AudioSessionHandler.swift
//  TribusDAmour
//
//  Created by Lab Comments: Stephane Lefebvre on 2023-08-13.
//  Copyright © Lab Comments: 2023 Stephane Lefebvre. All rights reserved.
//

import AVFoundation
import Combine

// Extension to define custom notification names
extension Notification.Name {
    static let audioInterruptionBegan = Notification.Name("audioInterruptionBegan")
    static let audioInterruptionEnded = Notification.Name("audioInterruptionEnded")
}

/// A handler for audio session interruptions.
final class AudioSessionHandler: ObservableObject {
    // Singleton instance
    static let shared = AudioSessionHandler()
    
    // Initialize the handler
    init() {
        setupInterruptionNotification()
    }

    // Set up an observer for audio interruption notifications
    func setupInterruptionNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleInterruption), name: AVAudioSession.interruptionNotification, object: nil)
    }
    
    // Handle the audio interruption notification
    @objc private func handleInterruption(notification: Notification) {
        guard let info = notification.userInfo,
              let typeRaw = info[AVAudioSessionInterruptionTypeKey] as? UInt,
              let type = AVAudioSession.InterruptionType(rawValue: typeRaw) else { return }

        switch type {
        case .began:
            // Post a notification for audio interruption beginning
            NotificationCenter.default.post(name: .audioInterruptionBegan, object: nil)
        case .ended:
            // Post a notification for audio interruption ending
            NotificationCenter.default.post(name: .audioInterruptionEnded, object: nil)
        @unknown default:
            // Handle unknown cases if needed
            break
        }
    }
}
