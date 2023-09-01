//
//  PodcastRowView.swift
//  TribusDAmour
//
//  Created by Stephane Lefebvre on 5/11/23.
//  Copyright © 2023 Stephane Lefebvre. All rights reserved.
//

import SwiftUI
import Kingfisher

// View responsible for displaying a single podcast row in a list
struct PodcastRowView: View {
    var podcast: PodcastData

    var body: some View {
        HStack {
            // Display the podcast image using Kingfisher
            KFImage(URL(string: podcast.imageUrl))
                .placeholder {
                    Image(systemName: "photo.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .accessibility(hidden: true) // Hide placeholder from accessibility
                }
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .accessibility(label: Text("Image of podcast \(podcast.title)"))
            
            VStack(alignment: .leading) {
                // Display the podcast title
                Text(podcast.title)
                    .font(.headline)
                    .accessibility(addTraits: .isHeader) // Mark as header for accessibility
                // Display the podcast author
                Text(podcast.author)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .accessibility(label: Text("Author: \(podcast.author)"))
            }
        }
    }
}

// Preview for the PodcastRowView
struct PodcastRowView_Previews: PreviewProvider {
    static var previews: some View {
        // Create a sample podcast for preview
        let samplePodcast = PodcastData(
            id: 1,
            title: "Sample Podcast",
            description: "This is a sample podcast for preview purposes.",
            author: "John Doe",
            releaseDate: "2023-07-27",
            duration: 3600,
            imageUrl: "",
            audioUrl: ""
        )
        // Display the PodcastRowView with the sample podcast
        return PodcastRowView(podcast: samplePodcast)
            .previewLayout(.sizeThatFits)
    }
}
