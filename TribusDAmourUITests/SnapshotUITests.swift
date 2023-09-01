//
//  SnapshotUITests.swift
//  TribusDAmourUITests
//
//  Created by Stephane Lefebvre on 2023-08-01.
//  Copyright © 2023 Stephane Lefebvre. All rights reserved.
//

import XCTest

class SnapshotUITests: XCTestCase {
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        let app = XCUIApplication()
        setupSnapshot(app)
        app.launch()
    }
    
    func testTakeScreenshots() throws {
        // Assuming you navigate to the PodcastDetailView from the main ContentView
        let app = XCUIApplication()
        
        // Tap on Podcasts tab
        app.tabBars.buttons["Podcasts"].tap()
        // Assuming there is a way to get to PodcastDetailView from here
        app.cells.firstMatch.tap()
        snapshot("01_PodcastDetailView")
        
        // Tap on Settings tab
        app.tabBars.buttons["Settings"].tap()
        snapshot("02_TBDASettingsView")
    }
}
