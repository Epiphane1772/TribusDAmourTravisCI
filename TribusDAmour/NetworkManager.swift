//
//  NetworkManager.swift
//  TribusDAmour
//
//  Created by Stephane Lefebvre on 2023-08-03.
//  Copyright © 2023 Stephane Lefebvre. All rights reserved.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager() // Singleton instance
    private let baseURL = "https://api.selconsulting.io"
    
    // Structs to handle the API response format
    struct APIResponse: Codable {
        let status: String
        let message: String
        let data: ResponseData
    }
    
    struct ResponseData: Codable {
        let token: String
        let user: User
    }
    
    struct User: Codable {
        let id: String
        let email: String
        let name: String
        let roles: [String]
    }
    
    func registerUser(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/register") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        let body: [String: Any] = ["email": email, "password": password]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
        } catch {
            completion(.failure(error))
            return
        }
        
        performDataTask(request: request, completion: completion)
    }
    
    func loginUser(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/login") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        let body: [String: Any] = ["email": email, "password": password]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
        } catch {
            completion(.failure(error))
            return
        }
        
        performDataTask(request: request, completion: completion)
    }
    
    // Utility function to reduce code repetition for data tasks
    private func performDataTask(request: URLRequest, completion: @escaping (Result<User, Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            // Printing the raw JSON response for debugging purposes:
            if let jsonData = data {
                print(String(data: jsonData, encoding: .utf8) ?? "Invalid data")
            }
            
            guard let data = data, error == nil else {
                completion(.failure(error!))
                return
            }
            
            do {
                let jsonResponse = try JSONDecoder().decode(APIResponse.self, from: data)
                
                if jsonResponse.status == "success" {
                    completion(.success(jsonResponse.data.user))
                } else {
                    let apiError = NSError(domain: "API Error", code: 0, userInfo: [NSLocalizedDescriptionKey: jsonResponse.message])
                    completion(.failure(apiError))
                }
                
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}
