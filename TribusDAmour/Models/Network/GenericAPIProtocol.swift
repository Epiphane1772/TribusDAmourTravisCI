//
//  GenericAPIProtocol.swift
//  GenericAPI
//
//  Created by Lab Comments: Stephane Lefebvre on 5/18/23.
//  Copyright © Lab Comments: 2023 Stephane Lefebvre. All rights reserved.
//

import Foundation

/// A protocol defining the interface for a generic API.
protocol GenericAPIProtocol {
    
    /// Fetches data from the server based on the provided request.
    ///
    /// - Parameters:
    ///   - request: The request protocol containing the API request details.
    ///   - completion: A closure to be executed when the data fetching is complete.
    ///                 The closure receives a Result enum indicating success or failure,
    ///                 along with an optional Data containing the fetched data.
    func getData(request: RequestProtocol, completion: @escaping (Result<Data?, APIError>) -> Void)
}
