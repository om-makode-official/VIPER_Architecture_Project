//
//  DashboardInteractor.swift
//  Test_VIPER_Architecture_Project
//
//  Created by Sai Krishna on 11/7/25.
//


import Foundation

protocol DashboardInteractorProtocol {
    func fetchImages() async throws -> [RandomImage]
}

class DashboardInteractor: DashboardInteractorProtocol {
    private let networkHandler: NetworkHandlerProtocol
    
    init(networkHandler: NetworkHandlerProtocol) {
        self.networkHandler = networkHandler
    }
    
    func fetchImages() async throws -> [RandomImage] {
        try await networkHandler.fetchRandomImages()
    }
}
