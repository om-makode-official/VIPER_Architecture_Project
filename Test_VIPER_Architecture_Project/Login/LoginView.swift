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
    @State private var showPassword = false
    
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
                .autocapitalization(.none)
                .disableAutocorrection(true)
            
            HStack{
                if showPassword{
                    TextField("Password", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                }
                else{
                    SecureField("Password", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                }
                Button(action: {
                    showPassword.toggle()
                    
                }){
                    Image(systemName: showPassword ? "eye.slash.fill" : "eye.fill")
                }
                       
            }
            
            
            
            Button("Login") {
                presenter.loginButtonTapped(email: email, password: password)
            }
            .buttonStyle(.borderedProminent)
            
            Button("Register"){
                presenter.registerButtonTapped()
            }
        
        }
        .padding()
        .alert(isPresented: $presenter.showErrorAlert) { 
                Alert(
                    title: Text("Login Failed"),
                    message: Text(presenter.errorMessage ?? "Invalid credentials"),
                    dismissButton: .default(Text("OK"))
                )
            }

    }
}
