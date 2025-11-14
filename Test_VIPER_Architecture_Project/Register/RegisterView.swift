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
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){
                        presenter.navigateToLogin()
                    }
                }
            })
        }
            
        
        
    }
    

}
