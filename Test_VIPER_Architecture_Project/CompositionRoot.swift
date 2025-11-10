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
        let networkHandler = NetworkHandler()
        let interactor = LoginInteractor(networkHandler: networkHandler)
        let router = LoginRouter(navigationController: navigationController)
        let presenter = LoginPresenter(interactor: interactor, router: router)
        let view = LoginView(presenter: presenter)
        
        interactor.presenter = presenter
        
        let vc = UIHostingController(rootView: view)
        navigationController.viewControllers = [vc]
    }
}

