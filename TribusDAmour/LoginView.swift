//
//  LoginView.swift
//  TribusDAmour
//
//  Created by Stephane Lefebvre on 2023-08-03.
//  Copyright © 2023 Stephane Lefebvre. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var loginSuccessful: Bool = false
    @State private var errorMessage: String?

    var body: some View {
        VStack(spacing: 20) {
            TextField("Email", text: $email)
                .padding()
                .border(Color.gray)
            
            SecureField("Password", text: $password)
                .padding()
                .border(Color.gray)
            
            Button("Login") {
                NetworkManager.shared.loginUser(email: email, password: password) { result in
                    switch result {
                    case .success(let user):
                        // Handle successful login
                        loginSuccessful = true
                        print("Logged in user with email: \(user.email)")
                    case .failure(let error):
                        errorMessage = error.localizedDescription
                    }
                }
            }
            .padding()
            
            if loginSuccessful {
                Text("Login Successful!")
                    .foregroundColor(.green)
            }
            
            if let error = errorMessage {
                Text(error)
                    .foregroundColor(.red)
            }
        }
        .padding()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
