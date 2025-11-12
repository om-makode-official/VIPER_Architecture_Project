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
                .bold()
            
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
                .autocapitalization(.none)
                .disableAutocorrection(true)
            
            ZStack{
                if showPassword{
                    TextField("Password", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .overlay(
                            Button(action: {
                                showPassword.toggle()
                            }) {
                                Image(systemName: showPassword ? "eye.slash.fill" : "eye.fill")
                                
                            }
                                .padding(.trailing, 30),
                            alignment: .trailing
                        )
                }
                else{
                    SecureField("Password", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .overlay(
                            Button(action: {
                                showPassword.toggle()
                            }) {
                                Image(systemName: showPassword ? "eye.slash.fill" : "eye.fill")
                                
                            }
                                .padding(.trailing, 30),
                            alignment: .trailing
                        )
                    
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
        .alert(item: $presenter.alertMessage) { msg in
                Alert(
                    title: Text(msg.title),
                    message: Text(msg.message),
                    dismissButton: .default(Text("OK")){
                        if case .success = msg{
                            presenter.alertMessage = nil
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                                presenter.handleSuccessNavigation()
                            }
                        }
                    }
                )
            }

    }
}
