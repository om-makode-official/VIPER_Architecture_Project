//
//  ProfileBuilder.swift
//  Test_VIPER_Architecture_Project
//
//  Created by Sai Krishna on 11/17/25.
//

import Foundation
import SwiftUI

class ProfileBuilder{
    
    func createModule(dashboard: DashboardPresenter) -> some View{
        
        let interactor = ProfileInteractor()
        let router = ProfileRouter(dashboard: dashboard)
        let presenter = ProfilePresenter(interactor: interactor, router: router)
        let view = ProfileView(presenter: presenter)
        
        return view
    }
}
