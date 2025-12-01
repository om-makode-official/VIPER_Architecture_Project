//
//  RegisterRouter.swift
//  Test_VIPER_Architecture_Project
//
//  Created by Sai Krishna on 11/7/25.
//

import Foundation
import UIKit
import SwiftUI


class RegisterRouter: RegisterRouterProtocol {
    
    var openLoginPage: () -> Void
    
    init(openLoginPage: @escaping () -> Void) {
        self.openLoginPage = openLoginPage
    }
    
    func navigateBackToLogin() {
        openLoginPage()
    }
}
