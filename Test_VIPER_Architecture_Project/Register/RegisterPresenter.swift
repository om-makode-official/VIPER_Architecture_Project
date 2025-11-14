//
//  RegisterPresenter.swift
//  Test_VIPER_Architecture_Project
//
//  Created by Sai Krishna on 11/7/25.
//

import Foundation

class RegisterPresenter: ObservableObject {
    private let interactor: RegisterInteractorProtocol
    private let router: RegisterRouterProtocol
    
    @Published var alertMessage: AlertType? = nil
    
    init(interactor: RegisterInteractorProtocol, router: RegisterRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
    
    func registerTapped(email: String, password: String) {
        
        guard !email.isEmpty, !password.isEmpty else {
            alertMessage = .error(message: StringConstants.fillAllFields)
            return
        }
                
        guard email.contains("@"), email.contains(".") else {
            alertMessage = .error(message: StringConstants.emailNotValid)
            return
        }
                
        guard password.count >= 6 else {
            alertMessage = .error(message: StringConstants.passCount)
            return
        }
        Task{
        
        let success = await interactor.registerUser(email: email, password: password)
            
            await MainActor.run {
                if success {
                    self.alertMessage = .success(message: StringConstants.regSuccess)
                    
                } else {
                    self.alertMessage = .error(message: StringConstants.alreadyExists)
                    
                }
            }
            
        }
    }
    func navigateToLogin() {
        router.navigateBackToLogin()
    }
}

