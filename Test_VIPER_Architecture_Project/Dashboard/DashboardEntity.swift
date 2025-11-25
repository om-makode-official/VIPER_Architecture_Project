//
//  DashboardEntity.swift
//  Test_VIPER_Architecture_Project
//
//  Created by Sai Krishna on 11/10/25.
//

import Foundation


struct RandomImage: Codable, Identifiable {
    let id: String
    let author: String
    var download_url: String
}

enum RandomImageLoadingStates {
    case idle
    case loading
    case loaded([RandomImage])
    case error(String, Bool)
}
