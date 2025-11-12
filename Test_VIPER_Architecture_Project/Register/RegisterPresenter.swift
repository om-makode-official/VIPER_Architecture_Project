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
        interactor.registerUser(email: email, password: password) { success in
            
            DispatchQueue.main.async {
                if success {
                    self.alertMessage = .success(message: "User Registered Successfully")
                    
                    DispatchQueue.main.asyncAfter(deadline: .now()+1){
                        
                        self.alertMessage = nil
                        self.router.navigateBackToLogin()
                    }
                    
                } else {
                    self.alertMessage = .error(message: "User Already Exists")
                    
                }
            }
            
        }
    }
}

