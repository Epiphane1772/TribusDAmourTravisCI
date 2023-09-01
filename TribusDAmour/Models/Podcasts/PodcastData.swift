//
//  PodcastData.swift
//  TribusDAmour
//
//  Created by Stephane Lefebvre on 2023/07/27.
//  Copyright © 2023 SEL Consulting. All rights reserved.
//

import Foundation
import CoreData
import SwiftUI

/// A struct representing podcast data that conforms to Codable and Identifiable protocols.
struct PodcastData: Codable, Identifiable {
    let id: Int
    let title: String
    let description: String
    let author: String
    let releaseDate: String
    let duration: Int
    let imageUrl: String
    let audioUrl: String

    enum CodingKeys: String, CodingKey {
        case id, title, description, author, duration, imageUrl, audioUrl
        case releaseDate = "releaseDate"
    }
}

extension PodcastData {
    /// Converts PodcastData to a Core Data Podcast entity and saves it to the provided context.
    static func toPodcast(context: NSManagedObjectContext, from podcastData: PodcastData) -> Podcast {
        let podcast = Podcast(context: context)
        podcast.id = Int32(podcastData.id)
        podcast.title = podcastData.title
        podcast.textDescription = podcastData.description
        podcast.author = podcastData.author
        podcast.duration = Int32(podcastData.duration)
        podcast.imageUrl = podcastData.imageUrl
        podcast.audioUrl = podcastData.audioUrl
        do {
            try context.save()
        } catch {
            print("Error saving podcast to context: \(error)")
        }
        return podcast
    }
}

extension Podcast {
    /// Converts a Core Data Podcast entity to a PodcastData struct.
    func toPodcastData() -> PodcastData {
        return PodcastData(
            id: Int(self.id),
            title: self.title ?? "",
            description: self.textDescription ?? "",
            author: self.author ?? "",
            releaseDate: "",
            duration: Int(self.duration),
            imageUrl: self.imageUrl ?? "",
            audioUrl: self.audioUrl ?? ""
        )
    }
}
