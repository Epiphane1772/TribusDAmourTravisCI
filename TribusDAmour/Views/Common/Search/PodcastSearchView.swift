//
//  PodcastSearchView.swift
//  TribusDAmour
//
//  Created by Stephane Lefebvre on 2023/07/28.
//  Copyright © 2023 SEL Consulting. All rights reserved.
//

import SwiftUI

// View responsible for searching and displaying podcasts
struct PodcastSearchView: View {
    @State private var searchText = ""
    @ObservedObject private var viewModel = PodcastSearchViewModel()
    @ObservedObject private var playerManager = PodcastPlayerManager(url: URL(string: "your_podcast_url_here")!) // Update the URL

    var body: some View {
        NavigationView {
            VStack {
                // Search bar for searching podcasts
                SearchBarView(text: $searchText, onSearch: {
                    if viewModel.voiceHints {
                        viewModel.announceSearching()
                    }
                    viewModel.searchForPodcasts(searchText: searchText)
                    searchText = ""
                    hideKeyboard()
                })
                .padding(.horizontal)
                .accessibility(addTraits: .isSearchField)
                .accessibility(label: Text("Search for podcasts"))

                // Display loading indicator or podcast list
                if viewModel.isLoading {
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .accessibility(label: Text("Loading podcasts, please wait..."))
                        .accessibilityValue(viewModel.isLoading ? Text("Loading") : Text("Finished loading"))
                } else {
                    PodcastListView(podcasts: $viewModel.podcasts)
                }

                // Display the podcast player
                PodcastPlayerView(playerManager: playerManager) // Pass the playerManager here
            }
            .navigationTitle("Search Podcasts")
            .accessibility(label: Text("Podcast search screen"))
        }
    }

    // Function to hide the keyboard
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
