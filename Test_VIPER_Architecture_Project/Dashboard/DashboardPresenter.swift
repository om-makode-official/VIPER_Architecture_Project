//
//  DashboardPresenter.swift
//  Test_VIPER_Architecture_Project
//
//  Created by Sai Krishna on 11/7/25.
//

import Foundation
import UIKit
import SwiftUI

class DashboardPresenter: ObservableObject, DashboardPresenterProtocol {
    
    
    @Published var loadingStates: RandomImageLoadingStates = .idle
    @Published var showProfileSheet = false
    
    @Published var name: String = ""
    @Published var imageURL: String = ""
    @Published var alertMessage: AlertType? = nil
    
    private var savedImage: RandomImage? = nil
    
    private let interactor: DashboardInteractorProtocol
    private let router: DashboardRouterProtocol
    
    
    
    init(interactor: DashboardInteractorProtocol, router: DashboardRouterProtocol) {
        self.interactor = interactor
        self.router = router

    }
    
    
    
    func logout(){
        let defaults = UserDefaults.standard
        defaults.set(false, forKey: "isLoggedIn")
        defaults.removeObject(forKey: "loggedInUserEmail")
        
        router.navigateToLogin()
    }
    
    func loadImagesFrommWeb() {
        self.loadingStates = .loading
        Task {
            do {
                let response = try await self.interactor.getImagesFromWeb()
                
                let addedImages = interactor.loadAddedImages()
                let combined = addedImages + response
                
                await MainActor.run{
                    self.loadingStates = .loaded(combined)
                }
            } catch {
                let error = error as? ApiError
                let errorMsg = error?.displayMsg ?? StringConstants.somethingWentWrong
                await MainActor.run(body: {
                    self.loadingStates = .error(errorMsg, errorMsg ==  StringConstants.checkInternet)
                })
            }
        }
    }
}
    
// MARK: - New Added Images(sheet)

    extension DashboardPresenter{
    
    func openProfileSheet(){
        name = ""
        imageURL = ""
        savedImage = nil
        showProfileSheet = true
    }
    
    func dismissSheet() {
        showProfileSheet = false
    }
    
    func saveImage() {
        guard !name.isEmpty, !imageURL.isEmpty else {
            alertMessage = .error(message: StringConstants.fillAllFields)
            return
            
        }
        
        guard imageURL.contains("http") || imageURL.contains("https") else{
            alertMessage = .error(message: StringConstants.invalidURL)
            return
        }
        
        Task{
            let newImage = interactor.createImage(name: name, url: imageURL)
            
            interactor.save(image: newImage)
            self.savedImage = newImage
        
        
        await MainActor.run{
            self.alertMessage = .success(message: "Image Added Successfully")
        }
        }
    }
    
    func returnData(){
        guard let image = savedImage else{
            let image = interactor.createImage(name: name, url: imageURL)
            addImageToDashboard(image: image)
            dismissSheet()
            return
        }
        addImageToDashboard(image: image)
        dismissSheet()
        
        
    }
    
    func addImageToDashboard(image: RandomImage) {
        if case .loaded(let oldData) = loadingStates {
            loadingStates = .loaded([image] + oldData)
        }else{
            loadingStates = .loaded([image])
        }
    }


}
