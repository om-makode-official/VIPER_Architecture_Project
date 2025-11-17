//
//  DashboardContracts.swift
//  Test_VIPER_Architecture_Project
//
//  Created by Sai Krishna on 11/10/25.
//

import Foundation
import UIKit

protocol DashboardInteractorProtocol {
    func getImagesFromWeb() async throws -> [RandomImage]
    func loadAddedImages() -> [RandomImage]
}

protocol DashboardPresenterProtocol: AnyObject {
    func loadImagesFrommWeb()
}

protocol DashboardRouterProtocol {
    func navigateToLogin()
}
