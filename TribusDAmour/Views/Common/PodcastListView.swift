//
//  PodcastListView.swift
//  TribusDAmour
//
//  Created by Stephane Lefebvre on 2023/07/27.
//  Copyright © 2023 SEL Consulting. All rights reserved.
//

import SwiftUI

// View responsible for displaying a list of podcasts
struct PodcastListView: View {
    @Binding var podcasts: [PodcastData]

    var body: some View {
        List {
            // Iterate through each podcast in the podcasts array
            ForEach(podcasts) { podcast in
                // Navigate to the PodcastDetailView when a podcast is tapped
                NavigationLink(destination: PodcastDetailView(podcast: podcast)) {
                    VStack(alignment: .leading) { // Group elements in a VStack
                        // Display the PodcastRowView for basic podcast information
                        PodcastRowView(podcast: podcast)
                            .accessibility(label: Text("Podcast: \(podcast.title) by \(podcast.author)"))
                        
                        // Display a brief portion of the podcast description
                        Text(podcast.description.prefix(60)) // Display around 2-3 lines of the description
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .lineLimit(2) // Limit to 2 lines
                    }
                }
            }
        }
        .navigationTitle("Podcasts") // Set the navigation title
        .accessibility(label: Text("List of Podcasts")) // Accessibility label for the list
    }
}

// Preview for the PodcastListView
struct PodcastListView_Previews: PreviewProvider {
    static var previews: some View {
        PodcastListView(podcasts: .constant([])) // Provide an empty array for preview
    }
}
