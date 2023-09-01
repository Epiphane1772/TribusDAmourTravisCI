//
//  PodcastCoreDataManagerTests.swift
//  TribusDAmourTests
//
//  Created by Stephane Lefebvre on 2023/08/18.
//  Copyritesint commit and pushght © 2023 SEL Consulting. All rights reserved.
//

@testable import TribusDAmour
import XCTest
import CoreData

class PodcastCoreDataManagerTests: XCTestCase {

    var coreDataStack: CoreDataStack!
    var manager: PodcastCoreDataManager!
    let mockPodcastData = PodcastData(id: 123, title: "Mock Title", description: "Mock Description", author: "Mock Author", releaseDate: "01/01/2023", duration: 60, imageUrl: "https://example.com/image.jpg", audioUrl: "https://example.com/audio.m4a")
    
    override func setUpWithError() throws {
        coreDataStack = CoreDataStack(modelName: "TribusDAmour")
        manager = PodcastCoreDataManager(context: coreDataStack.mainContext)
    }

    override func tearDownWithError() throws {
        coreDataStack = nil
        manager = nil
    }
    
    func testAddPodcast() {
        XCTAssertFalse(manager.exists(podcastData: mockPodcastData))
        manager.add(podcastData: mockPodcastData)
        XCTAssertTrue(manager.exists(podcastData: mockPodcastData))
    }
    
    func testRemovePodcast() {
        manager.add(podcastData: mockPodcastData)
        XCTAssertTrue(manager.exists(podcastData: mockPodcastData))
        manager.remove(podcastData: mockPodcastData)
        XCTAssertFalse(manager.exists(podcastData: mockPodcastData))
    }
    
    func testFetchAllPodcasts() {
        manager.add(podcastData: mockPodcastData)
        let podcasts = manager.fetchAllPodcasts()
        XCTAssertEqual(podcasts.count, 1)
        XCTAssertEqual(podcasts[0].id, mockPodcastData.id)
    }
}
