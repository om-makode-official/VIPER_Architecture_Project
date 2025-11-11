//
//  DashboardRouter.swift
//  Test_VIPER_Architecture_Project
//
//  Created by Sai Krishna on 11/11/25.
//

import Foundation
import UIKit

class DashboardRouter: DashboardRouterProtocol {
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func navigateToLogin() {
        let loginVC = LoginBuilder().createModule(navigationController: navigationController)
        navigationController.setViewControllers([loginVC], animated: true)
    }
}
