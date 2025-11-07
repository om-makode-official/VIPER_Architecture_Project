//
//  RegisterBuilder.swift
//  Test_VIPER_Architecture_Project
//
//  Created by Sai Krishna on 11/7/25.
//

import Foundation
import UIKit
import SwiftUI

class RegisterBuilder{
    func createModule(navigationController: UINavigationController?) -> UIViewController{
        let interactor = RegisterInteractor()
        let router = RegisterRouter(navigationController: navigationController)
        let presenter = RegisterPresenter(interactor: interactor, router: router)
        let view = RegisterView(presenter: presenter)
        return UIHostingController(rootView: view)
    }
}
