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
    func getImagesFromWeb() async throws -> [RandomImage]
}

protocol DashboardViewToPresenterProtocol: AnyObject {
    func viewDidLoadAsync() async
}



protocol DashboardRouterProtocol {
    func navigateToLogin()
}
