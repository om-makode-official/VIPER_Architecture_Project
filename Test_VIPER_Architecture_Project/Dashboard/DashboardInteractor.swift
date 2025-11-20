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
    
//    private let key = "addedImages"
    private let defaults = UserDefaults.standard
    
    init(networkHandler: NetworkHandlerProtocol) {
        self.networkHandler = networkHandler
        
    }

    func getImagesFromWeb() async throws -> [RandomImage] {
        let path = "https://picsum.photos/v2/list?page=9&limit=20"
        
        guard let response = try await self.networkHandler.fetchRandomImages(_url: path, result: [RandomImage].self) else {
            throw ApiError.message(StringConstants.somethingWentWrong)
        }
        return response
    }
    
}

// MARK: - New Added Images
    extension DashboardInteractor{
        
        private var currentUserKey: String{
            let email = defaults.string(forKey: "loggedInUserEmail") ?? "unknown"
            return "addedImages_\(email)"
        }
        

    func loadAddedImages() -> [RandomImage]{
        guard let data = defaults.data(forKey: currentUserKey), var images = try? JSONDecoder().decode([RandomImage].self, from: data) else{
            return []
        }
        for i in images.indices{
            images[i].isLocal = true
        }
        return images
    }
    
    func createImage(name: String, url: String) -> RandomImage {
        RandomImage(
            id: UUID().uuidString,
            author: name,
            download_url: url,
            isLocal: true
        )
    }
    
    func save(image: RandomImage){
        var images = loadAddedImages()
        images.append(image)
        
        if let data = try? JSONEncoder().encode(images){
            defaults.set(data, forKey: currentUserKey)
        }
    }
    
}

// MARK: - Edit Image

extension DashboardInteractor{
    
    func replaceImage(_ updated: RandomImage){
        var images = loadAddedImages()
        
        if let idx = images.firstIndex(where: {$0.id == updated.id}){
            images[idx] = updated
        }
        
        if let data = try? JSONEncoder().encode(images){
            defaults.set(data, forKey: currentUserKey)
        }
    }
    
}

// MARK: - Delete Image

extension DashboardInteractor{
    
    func removeImage(_ image: RandomImage){
        var images = loadAddedImages()
        images.removeAll { $0.id == image.id }
        
        if let data = try? JSONEncoder().encode(images){
            defaults.set(data, forKey: currentUserKey)
        }
    }
}
