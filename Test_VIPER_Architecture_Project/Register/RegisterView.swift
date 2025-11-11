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
        VStack(spacing: 20) {
            Text("Register")
                .font(.largeTitle)
                .bold()
            
            TextField("Enter Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
                .autocapitalization(.none)
                .disableAutocorrection(true)
            
            HStack{
                if showPassword{
                    TextField("Password", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                }
                else{
                    SecureField("Password", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                }
                Button(action: {
                    showPassword.toggle()
                    
                }){
                    Image(systemName: showPassword ? "eye.slash.fill" : "eye.fill")
                }
            }
            
            Button("Register") {
                if validateCredentials(){
                    presenter.registerTapped(email: email, password: password)
                }
            }
            .buttonStyle(.borderedProminent)
            .onChange(of: presenter.alertMessage){ msg in
                if let message = msg{
                    if message.contains("Successfully"){
                        alertTitle = "Success"
                    }
                    else if message.contains("Exists"){
                        alertTitle = "Error"
                    }
                    else{
                        alertTitle = "Message"
                    }
                    alertMessage = message
                    showAlert = true
                    
                    if message.contains("Successfully"){
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.9){
                            showAlert = false
                        }
                    }
                    
                    presenter.alertMessage = nil
                }
            }
            
        }
        .alert(isPresented: $showAlert){
            Alert(title: Text(alertTitle),
            message: Text(alertMessage),
                  dismissButton: .default(Text("Ok")))
        }
    }
    
    func validateCredentials() -> Bool{
        if email.isEmpty || password.isEmpty{
            alertMessage = "Please fill all fields"
            showAlert = true
            return false
        }
        
        if !email.contains("@") || !email.contains("."){
            alertMessage = "Please Enter a Valid Email"
            showAlert = true
            return false
        }
        
        if password.count < 6{
            alertMessage = "Password must have at least 6 characters"
            showAlert = true
            return false
        }
        return true
    }
}
