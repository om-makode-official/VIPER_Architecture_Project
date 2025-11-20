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
    @Published var passwordValidate: Double = 0.0
    
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
                
        if let err = validatePassword(password: password){
            alertMessage = .error(message: err)
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
    
    
    func validatePassword(password: String) -> String?{
        
        var score = 0
        var uppercase = false
        var lowercase = false
        var number = false
        
        if password.count >= 8 { score += 1 }
        
        for char in password{
            if char.isUppercase{
                uppercase = true
            }
            if char.isLowercase{
                lowercase = true
            }
            if char.isNumber{
                number = true
            }
        }
        
        if uppercase{
            score += 1
        }
        if lowercase{
            score += 1
        }
        if number{
            score += 1
        }
        
        passwordValidate = Double(score)
        
        if password.count < 8 {
                return "Password must be at least 8 characters long."
            }
            if !uppercase {
                return "Password must contain 1 uppercase letter."
            }
            if !lowercase {
                return "Password must contain 1 lowercase letter."
            }
            if !number {
                return "Password must contain 1 number."
            }
        
        
       return nil
        
    }
    

}

