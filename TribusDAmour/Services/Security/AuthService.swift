//
//  AuthService.swift
//  TribusDAmour
//
//  Created by Stephane Lefebvre on 2023-08-02.
//  Copyright © 2023 Stephane Lefebvre. All rights reserved.
//

import Foundation

class AuthService {
    
    static let shared = AuthService()
    

    
    func register(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {

    }
    
    func login(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {

    }
    
    func logout(completion: @escaping (Result<Void, Error>) -> Void) {

    }
}
