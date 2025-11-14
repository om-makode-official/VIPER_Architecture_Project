//
//  RegisterContracts.swift
//  Test_VIPER_Architecture_Project
//
//  Created by Sai Krishna on 11/10/25.
//

import Foundation

protocol RegisterInteractorProtocol {
    func registerUser(email: String, password: String) async -> Bool
}

protocol RegisterRouterProtocol {
    func navigateBackToLogin()
    
}
