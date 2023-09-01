//
//  ContentView.swift
//  TribusDAmour
//
//  Created by Stephane Lefebvre on 2023-08-01.
//  Copyright © 2023 Stephane Lefebvre. All rights reserved.
//

import SwiftUI

/// The main content view of the app.
struct ContentView: View {
    @EnvironmentObject var podcastViewModel: PodcastViewModel // Access to the podcast view model.

    var body: some View {
        TabView {
            PodcastSearchView() // Display the podcast search view.
                .tabItem {
                    Image(systemName: "play.circle")
                        .accessibility(label: Text("Podcasts")) // Accessibility label for the tab item.
                    Text("Podcasts") // Tab item text.
                }
                .accessibilityHint(Text("Tap to browse and play podcasts.")) // Accessibility hint.

            PodcastFavoriteView() // Display the favorite podcasts view.
                .tabItem {
                    Image(systemName: "star")
                        .accessibility(label: Text("Favorites")) // Accessibility label for the tab item.
                    Text("Favorites") // Tab item text.
                }
                .accessibilityHint(Text("Tap to see your favorite podcasts.")) // Accessibility hint.

            TBDASettingsView() // Display the settings view.
                .tabItem {
                    Image(systemName: "gear")
                        .accessibility(label: Text("Settings")) // Accessibility label for the tab item.
                    Text("Settings") // Tab item text.
                }
                .accessibilityHint(Text("Tap to access application settings.")) // Accessibility hint.
        }
        .environmentObject(podcastViewModel) // Inject the podcast view model as an environment object.
    }
}

/// A preview provider for the ContentView.
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(PodcastViewModel()) // Preview with a podcast view model.
    }
}
