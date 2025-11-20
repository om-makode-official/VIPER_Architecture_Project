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
    
    @Published var editingImageID: String? = nil
    
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
                let errorMsg = (error as? ApiError)?.displayMsg ?? StringConstants.somethingWentWrong
                let check = checkError(error)
                await MainActor.run(body: {
//                    self.loadingStates = .error(errorMsg, errorMsg ==  StringConstants.checkInternet)
                    self.loadingStates = .error(errorMsg, check)
                })
            }
        }
    }
    private func checkError(_ error: Error) -> Bool {
        let nsError = error as NSError
        return nsError.domain == NSURLErrorDomain
    }

}
    
// MARK: - New Added Images(sheet)

    extension DashboardPresenter{
    
    func openProfileSheet(){
        name = ""
        imageURL = ""
        savedImage = nil
        editingImageID = nil
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
        
        guard imageURL.contains("http") else{
            alertMessage = .error(message: StringConstants.invalidURL)
            return
        }
        
        Task{
            if let id = editingImageID{
                replaceImage(id: id)
            }else{
                let newImage = interactor.createImage(name: name, url: imageURL)
                
                interactor.save(image: newImage)
                self.savedImage = newImage
            }
            
        
        
        await MainActor.run{
            if editingImageID != nil{
                self.alertMessage = .success(message: "Image Updated Successfully")
            }else{
                self.alertMessage = .success(message: "Image Added Successfully")
            }
            
        }
        }
    }
    
    func returnData(){
        
        if editingImageID != nil{
            dismissSheet()
            editingImageID = nil
            return
        }
        if let image = savedImage{
            addImageToDashboard(image: image)
            
        }
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

// MARK: - Edit Image

extension DashboardPresenter{
    
    func editImage(_ image: RandomImage){
        name = image.author
        imageURL = image.download_url
        editingImageID = image.id
        showProfileSheet = true
        
    }
    
    func replaceImage(id: String){
        let updatedImage = RandomImage(id: id, author: name, download_url: imageURL, isLocal: true)
        interactor.replaceImage(updatedImage)
        
        if case .loaded(let oldImages) = loadingStates{
            let newList = oldImages.map { img in
                img.id == id ? updatedImage : img
            }
            loadingStates = .loaded(newList)
        }
        savedImage = updatedImage
    }
    
}

// MARK: - Delete Image

extension DashboardPresenter{
    
    func deleteImage(_ image: RandomImage){
        interactor.removeImage(image)
        
        if case .loaded(let oldList) = loadingStates{
            let newList = oldList.filter{ $0.id != image.id}
            loadingStates = .loaded(newList)
        }
    }
}
