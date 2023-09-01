//
//  RegistrationView.swift
//  TribusDAmour
//
//  Created by Stephane Lefebvre on 2023-08-03.
//  Copyright © 2023 Stephane Lefebvre. All rights reserved.
//

import SwiftUI

struct RegistrationView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var registrationSuccessful: Bool = false
    @State private var errorMessage: String?

    var body: some View {
        VStack(spacing: 20) {
            TextField("Email", text: $email)
                .padding()
                .border(Color.gray)
            
            SecureField("Password", text: $password)
                .padding()
                .border(Color.gray)
            
            Button("Register") {
                NetworkManager.shared.registerUser(email: email, password: password) { result in
                    switch result {
                    case .success(let user):
                        // Handle successful registration
                        registrationSuccessful = true
                        print("Registered user with email: \(user.email)")
                    case .failure(let error):
                        errorMessage = error.localizedDescription
                    }
                }
            }
            .padding()
            
            if registrationSuccessful {
                Text("Registration Successful!")
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

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
