//
//  ProfileInteractor.swift
//  Test_VIPER_Architecture_Project
//
//  Created by Sai Krishna on 11/14/25.
//

import Foundation


class ProfileInteractor: ProfileInteractorProtocol{
    
    private let key = "addedImages"
    private let defaults = UserDefaults.standard
    
    func createImage(name: String, url: String) -> RandomImage {
        RandomImage(
            id: UUID().uuidString,
            author: name,
            download_url: url
        )
    }
    
    func save(image: RandomImage){
        var images = load()
        images.append(image)
        
        if let data = try? JSONEncoder().encode(images){
            defaults.set(data, forKey: key)
        }
    }
    
    func load() -> [RandomImage]{
        guard let data = defaults.data(forKey: key), let images = try? JSONDecoder().decode([RandomImage].self, from: data) else{
            return []
        }
        return images
    }
}
