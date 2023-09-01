//
//  PodcastFavoriteView.swift
//  TribusDAmour
//
//  Created by Stephane Lefebvre on 2023-08-03.
//  Copyright © 2023 Stephane Lefebvre. All rights reserved.
//

import SwiftUI
import CoreData

struct PodcastFavoriteView: View {
    
    @Environment(\.managedObjectContext) var moc
    @State private var showSearchView: Bool = false

    @FetchRequest(
        entity: Podcast.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Podcast.id, ascending: false)]
    ) var favoritePodcasts: FetchedResults<Podcast>

    var favoritePodcastsData: [PodcastData] {
        favoritePodcasts.map { $0.toPodcastData() }
    }

    var body: some View {
        NavigationView {
            PodcastListView(podcasts: .constant(favoritePodcastsData))
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("Favorite Podcasts")
                    }
                }
                .navigationBarItems(trailing: Button(action: {
                    self.showSearchView.toggle()
                }) {
                    Image(systemName: "magnifyingglass")
                }
                .accessibility(identifier: "searchButton")
                .accessibility(label: Text("Search"))
                .accessibility(hint: Text("Tap to search favorite podcasts"))
                .accessibilityAction(named: Text("Search"), { self.showSearchView.toggle() })
                )
                .sheet(isPresented: $showSearchView) {
                    PodcastSearchView()
                }
        }
    }
}
