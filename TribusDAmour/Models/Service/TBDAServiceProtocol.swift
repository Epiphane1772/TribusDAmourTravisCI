//
//  TBDAServiceProtocol.swift
//  TribusDAmour
//
//  Created by Lab Comments: Stephane Lefebvre on 2023-08-17.
//  Copyright © Lab Comments: 2023 Stephane Lefebvre. All rights reserved.
//

import Foundation

/// A protocol defining the interface for a TribusDAmour service.
protocol TBDAServiceProtocol {
    /// Fetches a list of podcasts.
    ///
    /// - Parameter completion: A closure to be executed when the data fetching is complete.
    ///   The closure receives a Result enum indicating success or failure,
    ///   along with an array of PodcastData or an APIError.
    func fetchPodcasts(completion: @escaping (Result<[PodcastData], APIError>) -> Void)
    
    /// Searches for podcasts based on the provided search text.
    ///
    /// - Parameters:
    ///   - searchText: The text to search for.
    ///   - completion: A closure to be executed when the data fetching is complete.
    ///   The closure receives a Result enum indicating success or failure,
    ///   along with an array of PodcastData or an APIError.
    func searchPodcasts(searchText: String, completion: @escaping (Result<[PodcastData], APIError>) -> Void)
    
    /// Fetches a podcast with the specified ID.
    ///
    /// - Parameters:
    ///   - id: The ID of the podcast to fetch.
    ///   - completion: A closure to be executed when the data fetching is complete.
    ///   The closure receives a Result enum indicating success or failure,
    ///   along with a PodcastData or an APIError.
    func fetchPodcast(withId id: String, completion: @escaping (Result<PodcastData, APIError>) -> Void)
}
