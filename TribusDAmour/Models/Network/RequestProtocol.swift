//
//  RequestProtocol.swift
//  GenericAPI
//
//  Created by Lab Comments: Stephane Lefebvre on 5/11/23.
//  Copyright © Lab Comments: 2023 Stephane Lefebvre. All rights reserved.
//

import Foundation

/// A protocol defining the interface for an API request.
protocol RequestProtocol {
    /// The host of the API.
    var host: String { get }
    /// The path of the API endpoint.
    var path: String { get }
    /// The HTTP method for the request (e.g., GET, POST).
    var method: String { get }
    /// URL parameters for the request.
    var urlParams: [String: String]? { get }
    
    /// Converts the request details into a URLRequest object.
    ///
    /// - Returns: A URLRequest object based on the request details.
    /// - Throws: RequestError.invalidURL if the URL components cannot be formed.
    func asURLRequest() throws -> URLRequest
}

/// An enum representing possible errors during request handling.
enum RequestError: Error {
    case invalidURL
}

extension RequestProtocol {
    
    /// Converts the request details into a URLRequest object.
    ///
    /// - Returns: A URLRequest object based on the request details.
    /// - Throws: RequestError.invalidURL if the URL components cannot be formed.
    func asURLRequest() throws -> URLRequest {
        // Construct URL components based on the provided details.
        var components = URLComponents()
        components.scheme = "https" // Use HTTPS protocol
        components.host = host // Set the API host
        components.path = path // Set the API endpoint
        
        // Add URL parameters if available
        if let params = urlParams {
            components.queryItems = params.map { URLQueryItem(name: $0, value: $1) }
        }
        
        // Create URL from components and handle invalid URLs
        guard let url = components.url else { throw RequestError.invalidURL }
        
        // Create a URLRequest object based on the URL
        var request = URLRequest(url: url)
        request.httpMethod = method // Set the HTTP method
        return request
    }
}
