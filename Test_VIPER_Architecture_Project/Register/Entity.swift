//
//  Entity.swift
//  Test_VIPER_Architecture_Project
//
//  Created by Sai Krishna on 11/7/25.
//

import Foundation

struct Entity: Codable {
    let email: String
    let password: String
}

struct RandomImage: Codable, Identifiable {
    let id: String
    let author: String
    let download_url: String
}
