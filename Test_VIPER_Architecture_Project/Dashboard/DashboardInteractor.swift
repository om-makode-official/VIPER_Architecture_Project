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
    
    private var imageCache: [String: UIImage] = [:]
    
    init(networkHandler: NetworkHandlerProtocol) {
        self.networkHandler = networkHandler
    }
    
    func fetchImages() async throws -> [RandomImage] {
        
        try await networkHandler.fetchRandomImages()

    }
    
    func fetchImage(for urlString: String) async -> UIImage?{
        if let chacheImage = imageCache[urlString]{
            return chacheImage
        }
        
        guard let url = URL(string: urlString)
        else{
            return nil
        }
        let request = URLRequest(url: url)
        
        if let cacheResponse = URLCache.shared.cachedResponse(for: request), let image = UIImage(data: cacheResponse.data){
            imageCache[urlString] = image
            return image
        }
        
        do{
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let image = UIImage(data: data)
            else{
                return nil
            }
            
            let cacheResponse = CachedURLResponse(response: response, data: data)
            URLCache.shared.storeCachedResponse(cacheResponse, for: request)
            imageCache[urlString] = image
            
            return image
        }
        catch{
            return nil
        }
    }
    
}
