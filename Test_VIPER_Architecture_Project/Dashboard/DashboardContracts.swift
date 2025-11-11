//
//  DashboardContracts.swift
//  Test_VIPER_Architecture_Project
//
//  Created by Sai Krishna on 11/10/25.
//

import Foundation
import UIKit

protocol DashboardInteractorProtocol {
    func fetchImages() async throws -> [RandomImage]
    func fetchImage(for urlString: String) async -> UIImage?
}

protocol DashboardViewToPresenterProtocol: AnyObject {
    func viewDidLoad()
}



protocol DashboardRouterProtocol {
    func navigateToLogin()
}
