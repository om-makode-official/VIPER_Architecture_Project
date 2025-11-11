//
//  LoginPresenter.swift
//  Test_VIPER_Architecture_Project
//
//  Created by Sai Krishna on 11/7/25.
//

import Foundation

class LoginPresenter: ObservableObject, LoginViewToPresenterProtocol {
    
    private let interactor: LoginPresenterToInteractorProtocol
    private let router: LoginPresenterToRouterProtocol
    
    @Published var errorMessage: String?
    @Published var showErrorAlert = false
    
    init(interactor: LoginPresenterToInteractorProtocol,
         router: LoginPresenterToRouterProtocol) {
        
        self.interactor = interactor
        self.router = router
    }
    
    func loginButtonTapped(email: String, password: String) {
        
        errorMessage = nil

        interactor.loginUser(email: email, password: password)
        
    }
    
    func registerButtonTapped() {
            router.navigateToRegister()
        }
}

extension LoginPresenter: LoginInteractorToPresenterProtocol {
    
    func loginSuccess() {
        DispatchQueue.main.async {
            self.router.navigateToDashboard()
        }
    }
    
    func loginFailed(message: String) {
        
        DispatchQueue.main.async {
            self.errorMessage = message
            self.showErrorAlert = true
        }
    }
}

