//
//  DashboardBuilder.swift
//  Test_VIPER_Architecture_Project
//
//  Created by Sai Krishna on 11/7/25.
//

import Foundation
import UIKit
import SwiftUI

class DashboardBuilder {
    
    func createModule(navigationController: UINavigationController) -> UIViewController {
        
        
        let networkHandler = NetworkHandler()
        let interactor = DashboardInteractor(networkHandler: networkHandler)
        let router = DashboardRouter(navigationController: navigationController)
        let presenter = DashboardPresenter(interactor: interactor, router: router)
        let view = DashboardView(presenter: presenter)
        return UIHostingController(rootView: view)
    }
}
