//
//  RegisterInteractor.swift
//  Test_VIPER_Architecture_Project
//
//  Created by Sai Krishna on 11/7/25.
//

import Foundation


class RegisterInteractor: RegisterInteractorProtocol {
    
    func registerUser(email: String, password: String, completion: @escaping (Bool) -> Void) {
        let defaults = UserDefaults.standard
        
    
        var users: [Entity] = []
        
        if let data = defaults.data(forKey: "registeredUsers"),
        let savedUsers = try? JSONDecoder().decode([Entity].self, from: data) {
                users = savedUsers
            }
                
            
            if users.contains(where: { $0.email == email }) {
                completion(false) 
                return
            }
                
            
            let newUser = Entity(email: email, password: password)
            users.append(newUser)
            
            
            if let encoded = try? JSONEncoder().encode(users) {
                defaults.set(encoded, forKey: "registeredUsers")
                completion(true)
            } else {
                completion(false)
            }
    }
}

