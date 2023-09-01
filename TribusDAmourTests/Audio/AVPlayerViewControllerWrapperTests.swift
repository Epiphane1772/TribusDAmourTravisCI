//
//  AVPlayerViewControllerWrapperTests.swift
//  TribusDAmourTests
//
//  Created by ChatGPT on 2023-08-18.
//  Copyright © 2023 Stephane Lefebvre. All rights reserved.
//

import XCTest
import AVFoundation
import AVKit
@testable import TribusDAmour

class MockPlayerStatePersistence: PlayerStatePersistable {
    var storage: [URL: Double] = [:]
    
    func put(time: Double, for url: URL) {
        storage[url] = time
    }

    func get(for url: URL) -> Double {
        return storage[url] ?? 0.0
    }
}

class AVPlayerViewControllerWrapperTests: XCTestCase {

    var playerManager: PlayerManager!
    var mockPersistence: MockPlayerStatePersistence!

    override func setUp() {
        super.setUp()
        playerManager = PlayerManager.shared
        mockPersistence = MockPlayerStatePersistence()
    }

    override func tearDown() {
        playerManager = nil
        mockPersistence = nil
        super.tearDown()
    }
}
