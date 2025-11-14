//
//  NetworkHandler.swift
//  Test_VIPER_Architecture_Project
//
//  Created by Sai Krishna on 11/7/25.
//

import Foundation

protocol NetworkHandlerProtocol {
    func fetchRandomImages<T: Codable>(_url: String,result: T.Type) async throws -> T?
}

class NetworkHandler: NetworkHandlerProtocol {
    
    func fetchRandomImages<T>(_url: String, result: T.Type) async throws -> T? where T :Codable {
        guard let url = URL(string: _url) else {
            throw ApiError.message(StringConstants.invalidURL)
        }
        
        let urlRequest = URLRequest(url: url)
        let session = try await URLSession.shared.data(for: urlRequest)
        
        guard let response = session.1 as? HTTPURLResponse else {
            throw ApiError.message(StringConstants.somethingWentWrong)
        }
        guard response.statusCode == 200 else {
            throw ApiError.message(StringConstants.somethingWentWrong)
        }
        
        let codableResponse = try JSONDecoder().decode(T.self, from: session.0)
        
        return codableResponse
    }
}
