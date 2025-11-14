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


struct StringConstants{
    static let invalidURL = "URL is not Valid"
    static let noResponse = "No response from server"
    static let somethingWentWrong = "Something went Wrong"
    static let checkInternet = "Please check your Internet Connection"
    static let noData = "No Data Found"
}

struct APIurls {
    static let randomImageUrlPath = ""
}
