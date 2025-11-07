//
//  RegisterRouter.swift
//  Test_VIPER_Architecture_Project
//
//  Created by Sai Krishna on 11/7/25.
//

import Foundation
import UIKit
import SwiftUI

protocol RegisterRouterProtocol {
    func navigateBackToLogin()
}

class RegisterRouter: RegisterRouterProtocol {
    weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func navigateBackToLogin() {
        navigationController?.popViewController(animated: true)
    }
}
