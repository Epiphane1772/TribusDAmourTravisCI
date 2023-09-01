//
//  DataMapperTests.swift
//  TribusDAmourTests
//
//  Created by Stephane Lefebvre on 8/17/23.
//  Copyright © 2023 Stephane Lefebvre. All rights reserved.
//

import XCTest
@testable import TribusDAmour

class DataMapperTests: XCTestCase {

    struct MockModel: Decodable {
        let id: Int
        let name: String
    }

    func testMap_Success() {
        // Given
        let jsonData = """
        {
            "id": 1,
            "name": "Test"
        }
        """.data(using: .utf8)!
        
        // When
        let result: Result<MockModel, APIError> = DataMapper.map(jsonData, to: MockModel.self)
        
        // Then
        switch result {
        case .success(let model):
            XCTAssertEqual(model.id, 1)
            XCTAssertEqual(model.name, "Test")
        case .failure:
            XCTFail("Expected success but got failure")
        }
    }

    func testMap_DecodingError() {
        // Given
        let jsonData = """
        {
            "invalid_key": "value"
        }
        """.data(using: .utf8)!
        
        // When
        let result: Result<MockModel, APIError> = DataMapper.map(jsonData, to: MockModel.self)
        
        // Then
        switch result {
        case .success:
            XCTFail("Expected decoding error but got success")
        case .failure(let error):
            XCTAssertEqual(error, APIError.decodingError)
        }
    }
}
