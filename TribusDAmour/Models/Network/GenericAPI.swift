//
//  GenericAPI.swift
//  GenericAPI
//
//  Created by Lab Comments: Stephane Lefebvre on 5/11/23.
//  Copyright © Lab Comments: 2023 Stephane Lefebvre. All rights reserved.
//

import Foundation

class GenericAPI: GenericAPIProtocol {
        
    var urlSession: URLSession
        
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
        
    func getData(request: RequestProtocol, completion: @escaping (Result<Data?, APIError>) -> Void) {
        do {
            let urlRequest = try request.asURLRequest()
            let task = urlSession.dataTask(with: urlRequest) { data, response, error in
                // Print the received data
                if let responseData = data, let responseString = String(data: responseData, encoding: .utf8) {
                    print("Received data from API: \(responseString)")
                } else {
                    print("Received no data or failed to convert data to string.")
                }

                guard let data else {
                    completion(.failure(APIError.dataLoadError))
                    return
                }
                completion(.success(data))
            }
            task.resume()
        } catch {
            completion(.failure(APIError.dataLoadError))
        }
    }
}
