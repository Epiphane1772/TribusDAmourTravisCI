//
//  MockTBDAService.swift
//  TribusDAmourTests
//
//  Created by Stephane Lefebvre on 2023/07/28.
//  Copyright © 2023 SEL Consulting. All rights reserved.
//

@testable import TribusDAmour
import Foundation

class MockTBDAService: TBDAServiceProtocol {
    
    var mockPodcasts: [PodcastData] {
        guard let url = Bundle(for: type(of: self)).url(forResource: "MockPodcastSearchResult", withExtension: "txt"),
              let data = try? Data(contentsOf: url),
              let mockData = try? JSONDecoder().decode([PodcastData].self, from: data) else {
            return []
        }
        
        return mockData
    }
    
    var mockPodcast: PodcastData?
    var mockError: APIError?
    
    func fetchPodcasts(completion: @escaping (Result<[PodcastData], APIError>) -> Void) {
        if let error = mockError {
            completion(.failure(error))
            return
        }
        
        completion(.success(mockPodcasts))
    }
    
    func searchPodcasts(searchText: String, completion: @escaping (Result<[PodcastData], APIError>) -> Void) {
        if let error = mockError {
            completion(.failure(error))
            return
        }
        
        completion(.success(mockPodcasts))
    }
    
    func fetchPodcast(withId id: String, completion: @escaping (Result<PodcastData, APIError>) -> Void) {
        if let error = mockError {
            completion(.failure(error))
            return
        }
        
        if let podcast = mockPodcast {
            completion(.success(podcast))
        } else {
            completion(.failure(APIError.genericError))
        }
    }
}
