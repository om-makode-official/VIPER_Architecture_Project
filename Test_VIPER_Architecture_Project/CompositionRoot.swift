//
//  CompositionRoot.swift
//  Test_VIPER_Architecture_Project
//
//  Created by Sai Krishna on 11/7/25.
//

import Foundation
import UIKit
import SwiftUI

class CompositionRoot {
    func createInitialModule(navigationController: UINavigationController) {
        
        let defaults = UserDefaults.standard
        let isLoggedIn = defaults.bool(forKey: "isLoggedIn")
        
        if isLoggedIn{
            let dashboardVC = DashboardBuilder().createModule(navigationController: navigationController)
            navigationController.viewControllers = [dashboardVC]
        }
        else{
            let loginVC = LoginBuilder().createModule(navigationController: navigationController)
            navigationController.viewControllers = [loginVC]
            
        }

    }
}

