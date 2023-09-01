//
//  APIError.swift
//  GenericAPI
//
//  Created by Lab Comments: Stephane Lefebvre on 5/18/23.
//  Copyright © Lab Comments: 2023 Stephane Lefebvre. All rights reserved.
//

import Foundation

// MARK: - API Error Enum

/// Represents various API-related errors.
enum APIError: Error {
    case dataLoadError
    case decodingError
    case invalidResponse
    case requestFailed(message: String)
    case invalidRequest
    case networkError
    case invalidData
    case invalidURL
    case invalidRequestError
    case dataParseError
    case genericError
}

// MARK: - Equatable Conformance

extension APIError: Equatable {
    static func == (lhs: APIError, rhs: APIError) -> Bool {
        switch (lhs, rhs) {
        case (.dataLoadError, .dataLoadError),
             (.decodingError, .decodingError),
             (.invalidResponse, .invalidResponse),
             (.invalidRequest, .invalidRequest),
             (.networkError, .networkError),
             (.invalidData, .invalidData),
             (.invalidURL, .invalidURL),
             (.invalidRequestError, .invalidRequestError),
             (.dataParseError, .dataParseError):
            return true
        case let (.requestFailed(message: leftMessage), .requestFailed(message: rightMessage)):
            return leftMessage == rightMessage
        default:
            return false
        }
    }
}
