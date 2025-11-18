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
    
    private let key = "addedImages"
    private let defaults = UserDefaults.standard
    
    init(networkHandler: NetworkHandlerProtocol) {
        self.networkHandler = networkHandler
        
    }

    func getImagesFromWeb() async throws -> [RandomImage] {
        let path = "https://picsum.photos/v2/list?page=7&limit=15"
        
        guard let response = try await self.networkHandler.fetchRandomImages(_url: path, result: [RandomImage].self) else {
            throw ApiError.message(StringConstants.somethingWentWrong)
        }
        return response
    }
    
}

// MARK: - New Added Images
    extension DashboardInteractor{
        

    func loadAddedImages() -> [RandomImage]{
        guard let data = defaults.data(forKey: key), let images = try? JSONDecoder().decode([RandomImage].self, from: data) else{
            return []
        }
        return images
    }
    
    func createImage(name: String, url: String) -> RandomImage {
        RandomImage(
            id: UUID().uuidString,
            author: name,
            download_url: url
        )
    }
    
    func save(image: RandomImage){
        var images = loadAddedImages()
        images.append(image)
        
        if let data = try? JSONEncoder().encode(images){
            defaults.set(data, forKey: key)
        }
    }
    
}
