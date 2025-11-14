//
//  ErrorMsg.swift
//  Test_VIPER_Architecture_Project
//
//  Created by Sai Krishna on 11/12/25.
//

import Foundation

enum ApiError: Error {
    case message(String)
    
    var displayMsg: String {
        switch self {
        case .message(let msg):
            return msg
        }
    }
}


struct APIurls {
    static let randomImageUrlPath = ""
}
