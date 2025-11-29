//
//  CompositionRoot.swift
//  Test_VIPER_Architecture_Project
//
//  Created by Sai Krishna on 11/7/25.
//

import Foundation
import UIKit
import SwiftUI

//class CompositionRoot {
//    func createInitialModule(navigationController: UINavigationController) {
//
//        let defaults = UserDefaults.standard
//        let isLoggedIn = defaults.bool(forKey: "isLoggedIn")
//
//        if isLoggedIn{
//            let dashboardVC = DashboardBuilder().createModule(navigationController: navigationController)
//            navigationController.viewControllers = [dashboardVC]
//        }
//        else{
//            let loginVC = LoginBuilder().createModule(navigationController: navigationController)
//            navigationController.viewControllers = [loginVC]
//
//        }
//
//    }
//}


class CompositionRoot{
    
    
// MARK: - ----------------------------------------------------------------
    
//    let isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
    
//  If login status changes at runtime then CompositionRoot won’t know. so use following
    
    var isLoggedIn: Bool {
        UserDefaults.standard.bool(forKey: "isLoggedIn")
    }
    
// MARK: - ----------------------------------------------------------------
    
    
    private lazy var navigationVC: UINavigationController = {
        let vc = UINavigationController.init()
        return vc
    }()
    
    func getNavVC() -> UIViewController{
        return navigationVC
    }
    
    func navigateLoginPage(){
        
        if isLoggedIn{
            navigateToDashboardPage()
        }else{
            let vc = LoginBuilder().createModule(openRegisterPage: navigateToRegisterPage, openDashboardPage: navigateToDashboardPage)
            navigationVC.setViewControllers([vc], animated: true)
        }
        
        
    }
    
    func navigateToRegisterPage(){
        let vc = RegisterBuilder().createModule(openLoginPage: navigateLoginPage)
        navigationVC.pushViewController(vc, animated: true)
    }
    
    func navigateToDashboardPage(){
        let vc = DashboardBuilder().createModule(openLoginPage: navigateLoginPage)
        navigationVC.setViewControllers([vc], animated: true)
    }
    
}

