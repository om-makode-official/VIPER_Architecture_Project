//
//  LoginInterator.swift
//  Test_VIPER_Architecture_Project
//
//  Created by Sai Krishna on 11/7/25.
//

import Foundation

class LoginInteractor: LoginPresenterToInteractorProtocol {
    
    weak var presenter: LoginInteractorToPresenterProtocol?
    
    private let networkHandler: NetworkHandler
    
    init(networkHandler: NetworkHandler) {
        
        self.networkHandler = networkHandler
        
    }
    
    func loginUser(email: String, password: String) {
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
            
            
            if email == "test@gmail.com" && password == "123456" {
                self.presenter?.loginSuccess()
                
            } else {
                self.presenter?.loginFailed(message: "Invalid credentials")
                
            }
        }
    }
}
