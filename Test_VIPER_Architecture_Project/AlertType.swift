//
//  AlertType.swift
//  Test_VIPER_Architecture_Project
//
//  Created by Sai Krishna on 11/12/25.
//

import Foundation

enum AlertType: Identifiable {
    case success(message: String)
    case error(message: String)
    case alert(image: RandomImage)
    
    
    var id: String {
        switch self {
        case .success(let msg):
            return "success-\(msg)"
        case .error(let msg):
            return "error-\(msg)"
        case .alert(let image):
            return image.id
        }
    }
    
    var title: String {
        switch self {
        case .success:
            return "Success"
        case .error:
            return "Error"
        case .alert:
            return "Alert"
        }
    }
    
    var message: String {
        switch self {
        case .success(let msg),
                .error(let msg):
            return msg
        case .alert:
            return "Are you sure you want to delete this image?"

        }
    }
}
