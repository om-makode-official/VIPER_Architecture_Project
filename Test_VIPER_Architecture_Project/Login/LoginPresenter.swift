//
//  LoginPresenter.swift
//  Test_VIPER_Architecture_Project
//
//  Created by Sai Krishna on 11/7/25.
//

import Foundation

protocol LoginViewToPresenterProtocol: AnyObject {
    func loginButtonTapped(email: String, password: String)
}

protocol LoginPresenterToInteractorProtocol: AnyObject {
    func loginUser(email: String, password: String)
}

protocol LoginPresenterToRouterProtocol: AnyObject {
    func navigateToDashboard()
}

protocol LoginInteractorToPresenterProtocol: AnyObject {
    func loginSuccess()
    func loginFailed(message: String)
}

class LoginPresenter: ObservableObject, LoginViewToPresenterProtocol {
    
    private let interactor: LoginPresenterToInteractorProtocol
    private let router: LoginPresenterToRouterProtocol
    
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    init(interactor: LoginPresenterToInteractorProtocol,
         router: LoginPresenterToRouterProtocol) {
        
        self.interactor = interactor
        self.router = router
    }
    
    func loginButtonTapped(email: String, password: String) {
        
        errorMessage = nil
        isLoading = true
        interactor.loginUser(email: email, password: password)
    }
}

extension LoginPresenter: LoginInteractorToPresenterProtocol {
    func loginSuccess() {
        DispatchQueue.main.async {
            
            self.isLoading = false
            self.router.navigateToDashboard()
        }
    }
    
    func loginFailed(message: String) {
        
        DispatchQueue.main.async {
            
            self.isLoading = false
            self.errorMessage = message
        }
    }
}

