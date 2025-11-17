//
//  DashboardInteractor.swift
//  Test_VIPER_Architecture_Project
//
//  Created by Sai Krishna on 11/10/25.
//

import Foundation
import UIKit


class DashboardInteractor: DashboardInteractorProtocol {
    private let networkHandler: NetworkHandlerProtocol
    private let profileInteractor: ProfileInteractorProtocol
    
    
    init(networkHandler: NetworkHandlerProtocol, profileInteractor: ProfileInteractorProtocol) {
        self.networkHandler = networkHandler
        self.profileInteractor = profileInteractor
    }
    

    
    func getImagesFromWeb() async throws -> [RandomImage] {
        let path = "https://picsum.photos/v2/list?page=7&limit=15"
        
        guard let response = try await self.networkHandler.fetchRandomImages(_url: path, result: [RandomImage].self) else {
            throw ApiError.message(StringConstants.somethingWentWrong)
        }
        return response
    }
    
    func loadAddedImages() -> [RandomImage]{
        return profileInteractor.load()
    }
    
}
