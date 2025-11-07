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
        
        
        let presenter = DashboardPresenter()
        let view = DashboardView(presenter: presenter)
        
        
        
        let viewController = UIHostingController(rootView: view)
        
        return viewController
    }
}
