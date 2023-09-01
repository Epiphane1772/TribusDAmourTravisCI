//
//  PodcastSearchViewModel.swift
//  TribusDAmour
//
//  Created by Stephane Lefebvre on 2023/07/28.
//  Copyright © 2023 SEL Consulting. All rights reserved.
//

import SwiftUI
import AVFoundation

/// A view model class responsible for managing podcast search-related data.
class PodcastSearchViewModel: ObservableObject {
    @Published var podcasts: [PodcastData] = [] // Published property to store fetched podcast data.
    @Published var isLoading = false // Published property to indicate loading state.
    @AppStorage("voiceHints") var voiceHints = true // App storage for user's voice hints preference.
    private let speechSynthesizer = AVSpeechSynthesizer() // Speech synthesizer for voice announcements.
    private let tbdaService: TBDAServiceProtocol // Service for fetching podcast data.

    init(service: TBDAServiceProtocol = TBDAService.shared) {
        self.tbdaService = service
        searchForPodcasts(searchText: " ") // Initial fetch of podcasts.
    }

    // Fetch podcasts based on the provided search text.
    func searchForPodcasts(searchText: String, shouldSortByID: Bool = false) {
        isLoading = true
        tbdaService.searchPodcasts(searchText: searchText) { result in
            self.isLoading = false
            switch result {
            case .success(let fetchedPodcasts):
                // Sort podcasts by ID if needed.
                self.podcasts = shouldSortByID ? fetchedPodcasts.sorted(by: { $0.id < $1.id }) : fetchedPodcasts
                // Announce the number of found podcasts with voice hint.
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    if self.voiceHints {
                        let message = "Found \(fetchedPodcasts.count) podcasts."
                        self.announceMessage(message)
                    }
                }
            case .failure(let error):
                print("Error fetching podcasts: \(error)")
            }
        }
    }
    
    // Announce a message using the speech synthesizer.
    func announceMessage(_ message: String) {
        let utterance = AVSpeechUtterance(string: message)
        utterance.volume = 1.0
        speechSynthesizer.speak(utterance)
    }

    // Announce a searching message.
    func announceSearching() {
        let utterance = AVSpeechUtterance(string: "Searching...")
        utterance.volume = 1.0
        speechSynthesizer.speak(utterance)
    }
    
    // Announce a hint message for user guidance.
    func announceHint() {
        let utterance = AVSpeechUtterance(string: "Page to search for podcasts.")
        utterance.volume = 1.0
        speechSynthesizer.speak(utterance)
    }
}
