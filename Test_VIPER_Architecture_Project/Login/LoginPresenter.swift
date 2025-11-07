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

protocol LoginPresenterToInteractorProtocol {
    func loginUser(email: String, password: String, completion: @escaping (Bool) -> Void)
}

protocol LoginPresenterToRouterProtocol: AnyObject {
    func navigateToDashboard()
    func navigateToRegister()
}

protocol LoginInteractorToPresenterProtocol: AnyObject {
    func loginSuccess()
    func loginFailed(message: String)
}

class LoginPresenter: ObservableObject, LoginViewToPresenterProtocol {
    
    private let interactor: LoginPresenterToInteractorProtocol
    private let router: LoginPresenterToRouterProtocol
    
    @Published var errorMessage: String?
    
    init(interactor: LoginPresenterToInteractorProtocol,
         router: LoginPresenterToRouterProtocol) {
        
        self.interactor = interactor
        self.router = router
    }
    
    func loginButtonTapped(email: String, password: String) {
        
        errorMessage = nil

        interactor.loginUser(email: email, password: password){ success in
            if success{
                self.router.navigateToDashboard()
            }
            else{
                print("Invalid Credentialss")
            }
        }
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
        }
    }
}

