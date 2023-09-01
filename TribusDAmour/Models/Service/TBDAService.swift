//
//  TBDAService.swift
//  TribusDAmour
//
//  Created by Lab Comments: Stephane Lefebvre on 2023-08-02.
//  Copyright © Lab Comments: 2023 Stephane Lefebvre. All rights reserved.
//

import Foundation

/// Represents a service to interact with the TribusDAmour API.
class TBDAService: TBDAServiceProtocol {
    static let shared = TBDAService()
    private let api: GenericAPIProtocol

    init(api: GenericAPIProtocol = GenericAPI()) {
        self.api = api
    }

    /// Fetches a list of podcasts.
    ///
    /// - Parameter completion: A closure to be executed when the data fetching is complete.
    ///   The closure receives a Result enum indicating success or failure,
    ///   along with an array of PodcastData or an APIError.
    func fetchPodcasts(completion: @escaping (Result<[PodcastData], APIError>) -> Void) {
        let request = PodcastRequest.list
        fetchData(request: request, completion: completion)
    }

    /// Searches for podcasts based on the provided search text.
    ///
    /// - Parameters:
    ///   - searchText: The text to search for.
    ///   - completion: A closure to be executed when the data fetching is complete.
    ///   The closure receives a Result enum indicating success or failure,
    ///   along with an array of PodcastData or an APIError.
    func searchPodcasts(searchText: String, completion: @escaping (Result<[PodcastData], APIError>) -> Void) {
        let request = PodcastRequest.search(text: searchText)
        print("Searching podcasts with request: \(request)")
        fetchData(request: request, completion: completion)
    }

    /// Fetches a podcast with the specified ID.
    ///
    /// - Parameters:
    ///   - id: The ID of the podcast to fetch.
    ///   - completion: A closure to be executed when the data fetching is complete.
    ///   The closure receives a Result enum indicating success or failure,
    ///   along with a PodcastData or an APIError.
    func fetchPodcast(withId id: String, completion: @escaping (Result<PodcastData, APIError>) -> Void) {
        let request = PodcastRequest.singlePodcast(id: id)
        fetchData(request: request, completion: completion)
    }

    /// Fetches data from the API based on the provided request.
    ///
    /// - Parameters:
    ///   - request: The PodcastRequest object specifying the API request details.
    ///   - completion: A closure to be executed when the data fetching is complete.
    ///   The closure receives a Result enum indicating success or failure,
    ///   along with a decoded object or an APIError.
    private func fetchData<T: Decodable>(request: PodcastRequest, completion: @escaping (Result<T, APIError>) -> Void) {
        api.getData(request: request) { result in
            switch result {
            case .success(let data):
                guard let data = data else {
                    completion(.failure(.dataLoadError))
                    return
                }
                let decodedResult = DataMapper.map(data, to: T.self)
                DispatchQueue.main.async {
                    completion(decodedResult)
                }
            case .failure(let error):
                print("Error: \(error)")
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
}
