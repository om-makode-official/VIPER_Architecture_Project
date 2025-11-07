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
            
            SecureField("Enter Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            Button("Register") {
                presenter.registerTapped(email: email, password: password)
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}
