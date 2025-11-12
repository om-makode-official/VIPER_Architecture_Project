//
//  RegisterView.swift
//  Test_VIPER_Architecture_Project
//
//  Created by Sai Krishna on 11/7/25.
//

import Foundation
import SwiftUI

struct RegisterView: View {
    @StateObject private var presenter: RegisterPresenter
    
    @State private var email = ""
    @State private var password = ""
    @State private var showPassword = false
    
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var alertTitle = ""
    
    init(presenter: RegisterPresenter) {
        _presenter = StateObject(wrappedValue: presenter)
    }
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Register")
                .font(.largeTitle)
                .bold()
            
            TextField("Enter Email", text: $email)
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
                
                Button("Register") {
                    if validateCredentials(){
                        presenter.registerTapped(email: email, password: password)
                    }
                }
                .buttonStyle(.borderedProminent)
            
        }
            .onChange(of: presenter.alertMessage){ msg in
                guard let message = msg else {
                    return
                }
                alertTitle = message.title
                alertMessage = message.message
                showAlert = true
                
                presenter.alertMessage = nil
                }
            .alert(isPresented: $showAlert){
                Alert(title: Text(alertTitle),
                message: Text(alertMessage),
                dismissButton: .default(Text("Ok")))
            }
            
        
        
    }
    
    
    func validateCredentials() -> Bool{
        if email.isEmpty || password.isEmpty{
            presenter.alertMessage = .error(message: "Please fill all fields")
            return false
        }
        
        if !email.contains("@") || !email.contains("."){
            presenter.alertMessage =  .error(message: "Please Enter a Valid Email")
            return false
        }
        
        if password.count < 6{
            presenter.alertMessage = .error(message: "Password must have at least 6 characters")
            return false
        }
        return true
    }
}
