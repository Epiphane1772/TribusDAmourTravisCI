//
//  TBDAServiceTests.swift
//  TribusDAmourTests
//
//  Created by Stephane Lefebvre on 2023-08-17.
//  Copyright © 2023 Stephane Lefebvre. All rights reserved.
//

import XCTest
@testable import TribusDAmour

class MockAPI: GenericAPIProtocol {
    var mockData: Data?
    var mockError: APIError?
    
    func getData(request: RequestProtocol, completion: @escaping (Result<Data?, APIError>) -> Void) {
        if let data = mockData {
            completion(.success(data))
        } else if let error = mockError {
            completion(.failure(error))
        }
    }
}

class TBDAServiceTests: XCTestCase {
    
    var service: TBDAService!
    var mockAPI: MockAPI!

    override func setUp() {
        super.setUp()
        mockAPI = MockAPI()
        service = TBDAService(api: mockAPI)
    }
    
    func testFetchPodcasts() {
        let expectedPodcast = PodcastData(id: 1, title: "Test Title", description: "Test Description", author: "Test Author", releaseDate: "2023-08-17", duration: 60, imageUrl: "https://test.com/image.jpg", audioUrl: "https://test.com/audio.mp3")
        mockAPI.mockData = try! JSONEncoder().encode([expectedPodcast])
        
        service.fetchPodcasts { result in
            switch result {
            case .success(let podcasts):
                XCTAssertEqual(podcasts.count, 1)
                XCTAssertEqual(podcasts.first!.id, expectedPodcast.id)
                XCTAssertEqual(podcasts.first!.title, expectedPodcast.title)
            case .failure(let error):
                XCTFail("Expected success, got \(error) instead")
            }
        }
    }
}

