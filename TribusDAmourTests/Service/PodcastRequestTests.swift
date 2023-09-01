//
//  PodcastRequestTests.swift
//  TribusDAmourTests
//
//  Created by Stephane Lefebvre on 2023-08-17.
//  Copyright © 2023 Stephane Lefebvre. All rights reserved.
//

import XCTest
@testable import TribusDAmour

class PodcastRequestTests: XCTestCase {

    func testPodcastListRequest() {
        let request = PodcastRequest.list
        XCTAssertEqual(request.host, "api.selconsulting.io")
        XCTAssertEqual(request.path, "/podcast")
        XCTAssertEqual(request.method, "GET")
    }
    
    func testPodcastSingleRequest() {
        let id = "123"
        let request = PodcastRequest.singlePodcast(id: id)
        XCTAssertEqual(request.path, "/podcast/\(id)")
    }

    func testPodcastSearchRequest() {
        let searchText = "test"
        let request = PodcastRequest.search(text: searchText)
        XCTAssertEqual(request.path, "/podcast/search/\(searchText)")
    }
}
