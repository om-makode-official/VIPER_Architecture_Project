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
                        .onChange(of: password){ newValue in
                            presenter.validatePassword(password: newValue)
                        }
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
                        .onChange(of: password){ newValue in
                            presenter.validatePassword(password: newValue)
                        }
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
            Text("Password must contain at least 8 characters, 1 uppercase letter, 1 lowercase letter, and 1 number.")
                .font(.caption)
                .foregroundColor(.gray)
            Slider(value: $presenter.passwordValidate, in: 0...4, step: 1)
                .tint(.green)
                .padding(.horizontal)
                .disabled(true)
            
                Button("Register") {
                        presenter.registerTapped(email: email, password: password)
                }
                .buttonStyle(.borderedProminent)
            
        }


        .alert(item: $presenter.alertMessage) { msg in
            Alert(title: Text(msg.title),
                  message: Text(msg.message),
                  dismissButton: .default(Text("OK")){
                if case .success = msg{
                    presenter.alertMessage = nil
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                        presenter.navigateToLogin()
                    }
                }
            })
        }
            
        
        
    }
    

}
