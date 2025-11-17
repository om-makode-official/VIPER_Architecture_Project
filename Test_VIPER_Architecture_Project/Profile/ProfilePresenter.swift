//
//  ProfilePresenter.swift
//  Test_VIPER_Architecture_Project
//
//  Created by Sai Krishna on 11/14/25.
//

import Foundation

class ProfilePresenter: ObservableObject, ProfilePresenterProtocol{
    
    @Published var name: String = ""
    @Published var imageURL: String = ""
    @Published var alertMessage: AlertType? = nil
    
    private let interactor: ProfileInteractorProtocol
    private let router: ProfileRouterProtocol
    
    init(interactor: ProfileInteractorProtocol, router: ProfileRouterProtocol) {
        self.interactor = interactor
        self.router = router
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
        
        
        await MainActor.run{
            self.alertMessage = .success(message: "Image Added Successfully")
        }
        }
    }
    
    func dismiss() {
        router.dismissSheet()
    }
    
    func returnData(){
        
        let image = interactor.createImage(name: name, url: imageURL)
        router.returnDataToDashboard(image: image)
        router.dismissSheet()
    }

}
