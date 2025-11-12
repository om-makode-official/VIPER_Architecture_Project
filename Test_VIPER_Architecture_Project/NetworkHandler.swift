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
        let urlString = "https://picsum.photos/v2/list?page=7&limit=15"
        guard let url = URL(string: urlString) else {
//            throw URLError(.badURL)
            throw ApiError.message(StringConstants.invalidURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            //throw URLError(.badServerResponse)
            throw ApiError.message(StringConstants.noResponse)
        }
        
        guard httpResponse.statusCode == 200 else{
            throw ApiError.message(StringConstants.somethingWentWrong)
        }
        
        do{
            return try JSONDecoder().decode([RandomImage].self, from: data)
        }catch{
            throw ApiError.message(StringConstants.checkInternet)
        }

    }
}
