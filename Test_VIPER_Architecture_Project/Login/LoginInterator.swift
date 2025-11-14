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
        
        let defaults = UserDefaults.standard
                
        guard let data = defaults.data(forKey: "registeredUsers"),
                let users = try? JSONDecoder().decode([Entity].self, from: data) else {
            presenter?.loginFailed(message: "No registered users available in the database")
            return
            }
                
        if email.isEmpty || password.isEmpty{
            presenter?.loginFailed(message: "Please fill all fields")
        }else{
            if users.contains(where: { $0.email == email && $0.password == password }) {
                
                defaults.set(true, forKey: "isLoggedIn")
                defaults.set(email, forKey: "loggedInUserEmail")
                
                presenter?.loginSuccess()
            } else {
                presenter?.loginFailed(message: "Invalid Email and Password")
            }
        }
    }
    
}
