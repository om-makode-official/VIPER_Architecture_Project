//
//  LoginView.swift
//  Test_VIPER_Architecture_Project
//
//  Created by Sai Krishna on 11/7/25.
//

import Foundation
import SwiftUI

struct LoginView: View {
    
    @State private var email = ""
    @State private var password = ""
    
    @StateObject private var presenter: LoginPresenter
    
    init(presenter: LoginPresenter) {
        _presenter = StateObject(wrappedValue: presenter)
        
    }
    
    var body: some View {
        VStack(spacing: 16) {
            
            Text("Login")
                .font(.largeTitle)
            
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            
            Button("Login") {
                presenter.loginButtonTapped(email: email, password: password)
            }
            .buttonStyle(.borderedProminent)
            
            Button("Register"){
                presenter.registerButtonTapped()
            }
            
            if let error = presenter.errorMessage {
                
                Text(error).foregroundColor(.red)
            }
        }
        .padding()
    }
}
