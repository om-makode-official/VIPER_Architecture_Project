//
//  LoginRouter.swift
//  Test_VIPER_Architecture_Project
//
//  Created by Sai Krishna on 11/7/25.
//

import Foundation
//import UIKit
//import SwiftUI


class LoginRouter: LoginPresenterToRouterProtocol {
    

    var openRegisterPage: () -> Void
    var openDashboardPage: () -> Void
    
    init(openRegisterPage: @escaping () -> Void, openDashboardPage: @escaping () -> Void) {
        self.openRegisterPage = openRegisterPage
        self.openDashboardPage = openDashboardPage
    }
    
    func navigateToRegister(){
        openRegisterPage()
    }
    func navigateToDashboard(){
        openDashboardPage()
    }
    
}
