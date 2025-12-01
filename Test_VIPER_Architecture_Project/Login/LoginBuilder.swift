//
//  LoginBuilder.swift
//  Test_VIPER_Architecture_Project
//
//  Created by Sai Krishna on 11/7/25.
//

import Foundation
import SwiftUI

class LoginBuilder {
    
    func createModule(openRegisterPage: @escaping () -> Void, openDashboardPage: @escaping () -> Void) -> UIViewController{
        
        let interactor = LoginInteractor(networkHandler: NetworkHandler())
        let router = LoginRouter(openRegisterPage: openRegisterPage, openDashboardPage: openDashboardPage)
        let presenter = LoginPresenter(interactor: interactor, router: router)
        let view = LoginView(presenter: presenter)
        
        interactor.presenter = presenter
        
        return UIHostingController(rootView: view)
    }
    
    
    
}
