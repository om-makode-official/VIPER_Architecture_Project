//
//  AlertType.swift
//  Test_VIPER_Architecture_Project
//
//  Created by Sai Krishna on 11/12/25.
//

import Foundation

enum AlertType: Identifiable, Equatable {
    case success(message: String)
    case error(message: String)
    
    
    var id: UUID{
        return UUID()
    }
    
    var title: String {
        switch self {
        case .success:
            return "Success"
        case .error:
            return "Error"
        }
    }
    
    var message: String {
        switch self {
        case .success(let msg),
             .error(let msg):
            return msg
        }
    }
}
