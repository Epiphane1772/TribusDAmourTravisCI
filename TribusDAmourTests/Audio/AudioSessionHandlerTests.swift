//
//  AudioSessionHandlerTests.swift
//  TribusDAmourTests
//
//  Created by ChatGPT on 2023-08-18.
//  Copyright © 2023 Stephane Lefebvre. All rights reserved.
//

import XCTest
import AVFoundation
@testable import TribusDAmour

class AudioSessionHandlerTests: XCTestCase {

    var audioSessionHandler: AudioSessionHandler!

    override func setUp() {
        super.setUp()
        audioSessionHandler = AudioSessionHandler.shared
    }
}
