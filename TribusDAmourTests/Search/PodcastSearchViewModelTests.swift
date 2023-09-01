//
//  PodcastSearchViewModelTests.swift
//  TribusDAmourTests
//
//  Created by Stephane Lefebvre on 2023/07/28.
//  Copyright © 2023 SEL Consulting. All rights reserved.
//

@testable import TribusDAmour
import XCTest
import Foundation

class PodcastSearchViewModelTests: XCTestCase {
    var viewModel: PodcastSearchViewModel!
    var mockService: MockTBDAService!

    override func setUp() {
        super.setUp()
        mockService = MockTBDAService()
        viewModel = PodcastSearchViewModel(service: mockService)
    }
    
    func testFetchPodcastMethod() {
        let mockSource = "TestSource"
        viewModel.searchForPodcasts(searchText: mockSource)
        XCTAssertEqual(viewModel.podcasts.count, 4)
        XCTAssertEqual(viewModel.podcasts.first?.id, 11)
    }

    override func tearDown() {
        viewModel = nil
        mockService = nil
        super.tearDown()
    }
}
