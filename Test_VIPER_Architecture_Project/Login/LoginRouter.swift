//
//  LoginRouter.swift
//  Test_VIPER_Architecture_Project
//
//  Created by Sai Krishna on 11/7/25.
//

import Foundation
import UIKit
import SwiftUI

protocol LoginRouterProtocol {
    func navigateToDashboard()
    func navigateToRegister()
}

class LoginRouter: LoginPresenterToRouterProtocol {
    
    private let navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        
        self.navigationController = navigationController
        
        
    }
    
    func navigateToDashboard() {
        let dashboardVC = DashboardBuilder().createModule()
        
        navigationController?.pushViewController(dashboardVC, animated: true)
    }
    
    func navigateToRegister(){
        let registerVC = RegisterBuilder().createModule(navigationController: navigationController)
        navigationController?.pushViewController(registerVC, animated: true)
    }
}
