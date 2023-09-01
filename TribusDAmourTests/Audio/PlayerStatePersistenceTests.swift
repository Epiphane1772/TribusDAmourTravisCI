//
//  PlayerStatePersistenceTests.swift
//  TribusDAmourTests
//
//  Created by Stephane Lefebvre on 2023-08-17.
//  Copyright © 2023 Stephane Lefebvre. All rights reserved.
//

import XCTest
@testable import TribusDAmour

class PlayerStatePersistenceTests: XCTestCase {

    let testURL = URL(string: "https://example.com/audiofile.mp3")!
    let testTime: Double = 123.456

    override func setUpWithError() throws {
        // Stub
    }

    override func tearDownWithError() throws {
        UserDefaults.standard.removeObject(forKey: "PlayerState-\(testURL.absoluteString)")
    }

    func testPutAndGetTime() throws {
        PlayerStatePersistence.shared.put(time: testTime, for: testURL)
        let retrievedTime = PlayerStatePersistence.shared.get(for: testURL)
        XCTAssertEqual(testTime, retrievedTime, "Saved time should match the retrieved time.")
    }

    func testGetTimeForNonexistentURL() throws {
        let nonExistentTime = PlayerStatePersistence.shared.get(for: URL(string: "https://nonexistent.com/audio.mp3")!)
        XCTAssertEqual(nonExistentTime, 0, "Time for a non-existent URL should be 0.")
    }
}
