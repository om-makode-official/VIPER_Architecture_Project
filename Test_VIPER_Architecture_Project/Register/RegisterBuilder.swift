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
    
    func createModule(openLoginPage: @escaping () -> Void) -> UIViewController{
        let interactor = RegisterInteractor()
        let router = RegisterRouter(openLoginPage: openLoginPage)
        let presenter = RegisterPresenter(interactor: interactor, router: router)
        let view = RegisterView(presenter: presenter)
        return UIHostingController(rootView: view)
    }
    
}
