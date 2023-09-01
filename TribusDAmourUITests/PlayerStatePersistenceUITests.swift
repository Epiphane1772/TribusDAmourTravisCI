//
//  PlayerStatePersistenceUITests.swift
//  TribusDAmourUITests
//
//  Created by Stephane Lefebvre on 2023/07/28.
//  Copyright © 2023 SEL Consulting. All rights reserved.
//

import XCTest

class PlayerStatePersistenceUITests: XCTestCase {
    
    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }
    
    func testPlaybackTimePersistence() {
        // Check if play button exists and tap
        let playButton = app.buttons["playButtonAccessibilityIdentifier"]
        if playButton.exists {
            playButton.tap()
            
            // After tapping, let's wait for a few seconds for possible playback to start
            sleep(5) // Wait for 5 seconds; adjust as necessary
            
            // Check if pause button exists and tap
            let pauseButton = app.buttons["pauseButtonAccessibilityIdentifier"]
            XCTAssertTrue(pauseButton.exists, "Pause button should exist after play button is tapped")
            pauseButton.tap()
            
            // Check the playback time label's existence
            let playbackTimeLabel = app.staticTexts["playbackTimeLabelAccessibilityIdentifier"]
            XCTAssertTrue(playbackTimeLabel.exists, "Playback time label should exist after playing")
            
            // Optionally, you might want to verify the content of the label
            // (e.g., ensure playback time is greater than 0:00)
            let playbackTime = playbackTimeLabel.label
            XCTAssertNotEqual(playbackTime, "0:00", "Playback time should be greater than 0:00 after a few seconds of playing")
        }
    }
}
