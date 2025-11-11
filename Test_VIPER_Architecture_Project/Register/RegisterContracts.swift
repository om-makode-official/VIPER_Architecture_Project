//
//  RegisterContracts.swift
//  Test_VIPER_Architecture_Project
//
//  Created by Sai Krishna on 11/10/25.
//

import Foundation

protocol RegisterInteractorProtocol {
    func registerUser(email: String, password: String, completion: @escaping (Bool) -> Void)
}

protocol RegisterRouterProtocol {
    func navigateBackToLogin()
}
