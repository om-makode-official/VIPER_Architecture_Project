//
//  LoginContracts.swift
//  Test_VIPER_Architecture_Project
//
//  Created by Sai Krishna on 11/10/25.
//

import Foundation

protocol LoginViewToPresenterProtocol: AnyObject {
    func loginButtonTapped(email: String, password: String)
}

protocol LoginPresenterToInteractorProtocol {
    func loginUser(email: String, password: String)
}

protocol LoginPresenterToRouterProtocol: AnyObject {
    func navigateToDashboard()
    func navigateToRegister()
}

protocol LoginInteractorToPresenterProtocol: AnyObject {
    func loginSuccess()
    func loginFailed(message: String)
}

protocol LoginRouterProtocol {
    func navigateToDashboard()
    func navigateToRegister()
}
