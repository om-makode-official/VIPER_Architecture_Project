//
//  NetworkHandler.swift
//  Test_VIPER_Architecture_Project
//
//  Created by Sai Krishna on 11/7/25.
//

import Foundation

protocol NetworkHandlerProtocol {
    func fetchRandomImages() async throws -> [RandomImage]
}


class NetworkHandler: NetworkHandlerProtocol {
    
    func fetchRandomImages() async throws -> [RandomImage] {
        let urlString = "https://picsum.photos/v2/list?page=4&limit=15"
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        let images = try JSONDecoder().decode([RandomImage].self, from: data)
        return images
    }
}
