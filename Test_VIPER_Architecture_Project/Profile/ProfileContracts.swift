//
//  ProfileContracts.swift
//  Test_VIPER_Architecture_Project
//
//  Created by Sai Krishna on 11/14/25.
//

import Foundation

protocol ProfilePresenterProtocol: AnyObject{
    func saveImage()
    func dismiss()
}

protocol ProfileRouterProtocol {
    func dismissSheet()
    func returnDataToDashboard(image: RandomImage)
}

protocol ProfileInteractorProtocol {
    func createImage(name: String, url: String) -> RandomImage
    func load() -> [RandomImage]
    func save(image: RandomImage)
}
