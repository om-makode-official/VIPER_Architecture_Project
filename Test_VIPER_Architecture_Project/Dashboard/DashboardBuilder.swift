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
    
    func createModule() -> UIViewController {
        
        
        let networkHandler = NetworkHandler()
        let interactor = DashboardInteractor(networkHandler: networkHandler)
        let presenter = DashboardPresenter(interactor: interactor)
        let view = DashboardView(presenter: presenter)
        return UIHostingController(rootView: view)
    }
}
