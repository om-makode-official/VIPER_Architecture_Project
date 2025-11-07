//
//  LoginBuilder.swift
//  Test_VIPER_Architecture_Project
//
//  Created by Sai Krishna on 11/7/25.
//

import Foundation
import SwiftUI
import UIKit

class LoginBuilder {
    func createModule(navigationController: UINavigationController?) -> UIViewController {
        
        let interactor = LoginInteractor(networkHandler: NetworkHandler())
        let router = LoginRouter(navigationController: navigationController)
        let presenter = LoginPresenter(interactor: interactor, router: router)
        let view = LoginView(presenter: presenter)
        
        return UIHostingController(rootView: view)
    }
}
