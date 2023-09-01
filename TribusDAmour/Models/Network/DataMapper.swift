//
//  DataMapper.swift
//  GenericAPI
//
//  Created by Lab Comments: Stephane Lefebvre on 5/18/23.
//  Copyright © Lab Comments: 2023 Stephane Lefebvre. All rights reserved.
//

import Foundation

class DataMapper {
    // MARK: - Mapping Function
    
    /// Maps raw data to a specified Decodable type.
    ///
    /// - Parameters:
    ///   - data: The raw data to be decoded.
    ///   - type: The Decodable type to map the data to.
    /// - Returns: A Result containing the mapped object or an APIError.
    static func map<T: Decodable>(_ data: Data, to type: T.Type) -> Result<T, APIError> {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(T.self, from: data)
            return .success(decodedData)
        } catch {
            return .failure(APIError.decodingError)
        }
    }
}
