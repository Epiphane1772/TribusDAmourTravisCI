//
//  AudioPlayerManagerTests.swift
//  TribusDAmourTests
//
//  Created by Stephane Lefebvre on 2023-08-18.
//  Copyright © 2023 Stephane Lefebvre. All rights reserved.
//

import XCTest
@testable import TribusDAmour

class AudioPlayerManagerTests: XCTestCase {

    var manager: AudioPlayerManager!

    override func setUp() {
        super.setUp()
        manager = AudioPlayerManager.shared
    }
    
    func testPlayAndStop() {
        let expectation = self.expectation(description: "Audio started and stopped")
        let mockURL = URL(string: "https://example.com/audio.mp3")!
        
        manager.playAudioFrom(url: mockURL)
        XCTAssertTrue(manager.isPlaying)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.manager.stopPlayback()
            XCTAssertFalse(self.manager.isPlaying)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
}
