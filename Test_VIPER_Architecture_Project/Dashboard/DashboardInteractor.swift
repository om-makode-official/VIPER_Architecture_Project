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
        
        private var currentUserEmail: String{
            defaults.string(forKey: "loggedInUserEmail") ?? "unknown"
            
        }
        private var addedImagesKey: String {
            "addedImages_\(currentUserEmail)"
        }
        private var apiImagesKey: String {
            "apiImages_\(currentUserEmail)"
        }

        private var apiLoadedKey: String {
            "isAPILoaded_\(currentUserEmail)"
        }
        

    func loadAddedImages() -> [RandomImage]{
        guard let data = defaults.data(forKey: addedImagesKey), let images = try? JSONDecoder().decode([RandomImage].self, from: data) else{
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
//        images.append(image)
        images.insert(image, at: 0)
        
        if let data = try? JSONEncoder().encode(images){
            defaults.set(data, forKey: addedImagesKey)
        }
    }
    
}

// MARK: - Edit Image

extension DashboardInteractor{
    
    func replaceImage(_ updated: RandomImage){
        var added = loadAddedImages()
        
        if let idx = added.firstIndex(where: {$0.id == updated.id}){
            added[idx] = updated
            if let data = try? JSONEncoder().encode(added){
                defaults.set(data, forKey: addedImagesKey)
            }
            return
        }
        
        var apiImages = loadInitialAPIImages()
        if let idx = apiImages.firstIndex(where: { $0.id == updated.id }){
            apiImages[idx] = updated
            saveAPIImages(apiImages)
            return
        }
        
        var newAdded = loadAddedImages()
        newAdded.insert(updated, at: 0)
        if let data = try? JSONEncoder().encode(newAdded){
            defaults.set(data, forKey: addedImagesKey)
        }
    }
    
}

// MARK: - Delete Image

extension DashboardInteractor{
    
    func removeImage(_ image: RandomImage){
        var added = loadAddedImages()
        
        if !added.isEmpty{
            added.removeAll { $0.id == image.id }
            if let data = try? JSONEncoder().encode(added){
                defaults.set(data, forKey: addedImagesKey)
            }
        }
        
        var apiImages = loadInitialAPIImages()
        if !apiImages.isEmpty{
            apiImages.removeAll{ $0.id == image.id}
            saveAPIImages(apiImages)
        }
        
        
        
    }
}


extension DashboardInteractor{
    
    func isAPILoaded() -> Bool{
        defaults.bool(forKey: apiLoadedKey)
    }
    
    func setAPILoaded(){
        defaults.set(true, forKey: apiLoadedKey)
    }
    func saveInitialAPIImages(_ images: [RandomImage]) {
            saveAPIImages(images)
        }
    
    func saveAPIImages(_ images: [RandomImage]){
        if let data = try? JSONEncoder().encode(images){
            defaults.set(data, forKey: apiImagesKey)
        }
    }
    func loadInitialAPIImages() -> [RandomImage] {
        guard let data = defaults.data(forKey: apiImagesKey),
              let images = try? JSONDecoder().decode([RandomImage].self, from: data) else {
            return []
        }
        return images
    }
}
