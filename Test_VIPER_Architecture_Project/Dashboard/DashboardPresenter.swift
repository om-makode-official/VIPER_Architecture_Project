//
//  DashboardPresenter.swift
//  Test_VIPER_Architecture_Project
//
//  Created by Sai Krishna on 11/7/25.
//

import Foundation
import UIKit


class DashboardPresenter: ObservableObject, DashboardPresenterProtocol {
    

    @Published var loadingStates: RandomImageLoadingStates = .idle
    
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
                if response.isEmpty == false {
                    await MainActor.run(body: {
                        self.loadingStates = .loaded(response)
                    })
                } else {
                    await MainActor.run(body: {
                        self.loadingStates = .error(StringConstants.noData, false)
                    })
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
