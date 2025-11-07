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
    
    func loginUser(email: String, password: String, completion: @escaping (Bool) -> Void) {
        
        let defaults = UserDefaults.standard
                
        guard let data = defaults.data(forKey: "registeredUsers"),
                let users = try? JSONDecoder().decode([Entity].self, from: data) else {
            completion(false)
            return
            }
                
        
            if users.contains(where: { $0.email == email && $0.password == password }) {
                completion(true)
            } else {
                completion(false)
            }
    }
        
        
        
        
//        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
//
//
//            if email == "test@gmail.com" && password == "123456" {
//                self.presenter?.loginSuccess()
//
//            } else {
//                self.presenter?.loginFailed(message: "Invalid credentials")
//
//            }
//        }
    
}
