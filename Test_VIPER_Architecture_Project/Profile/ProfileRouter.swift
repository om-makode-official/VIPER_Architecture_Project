//
//  ProfileRouter.swift
//  Test_VIPER_Architecture_Project
//
//  Created by Sai Krishna on 11/14/25.
//

import Foundation

class ProfileRouter: ProfileRouterProtocol{
    
    weak var dashboardPresenter: DashboardPresenter?

      init(dashboard: DashboardPresenter) {
          self.dashboardPresenter = dashboard
      }

      func dismissSheet() {
          dashboardPresenter?.showProfileSheet = false
      }

      func returnDataToDashboard(image: RandomImage) {
          dashboardPresenter?.addImageToDashboard(image: image)
          dismissSheet()
      }
}
