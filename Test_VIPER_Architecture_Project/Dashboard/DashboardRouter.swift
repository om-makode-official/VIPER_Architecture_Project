//
//  DashboardRouter.swift
//  Test_VIPER_Architecture_Project
//
//  Created by Sai Krishna on 11/11/25.
//

import Foundation
import UIKit

class DashboardRouter: DashboardRouterProtocol {
    
    var openLoginPage: () -> Void
    
    init(openLoginPage: @escaping () -> Void) {
        self.openLoginPage = openLoginPage
    }
    
    func navigateToLogin() {
        openLoginPage()
        
    }
}
