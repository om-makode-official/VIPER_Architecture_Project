//
//  LoginRouter.swift
//  Test_VIPER_Architecture_Project
//
//  Created by Sai Krishna on 11/7/25.
//

import Foundation
import UIKit
import SwiftUI

class LoginRouter: LoginPresenterToRouterProtocol {
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        
        self.navigationController = navigationController
        
        
    }
    
    func navigateToDashboard() {
        let dashboardVC = DashboardBuilder().createModule()
        
        navigationController.pushViewController(dashboardVC, animated: true)
    }
}
