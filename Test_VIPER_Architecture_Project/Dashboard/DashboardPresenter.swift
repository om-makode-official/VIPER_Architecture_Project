//
//  DashboardPresenter.swift
//  Test_VIPER_Architecture_Project
//
//  Created by Sai Krishna on 11/7/25.
//

import Foundation
import UIKit


class DashboardPresenter: ObservableObject, DashboardViewToPresenterProtocol {
    
    @Published var images: [RandomImage] = []
    @Published var imageCache: [String: UIImage] = [:]
    @Published var isLoading = false
    @Published var loadingImages: Set<String> = []
    @Published var failedImages: Set<String> = []
    @Published var loadingStates: RandomImageLoadingStates = .idle
    
    private let interactor: DashboardInteractorProtocol
    private let router: DashboardRouterProtocol
    
    init(interactor: DashboardInteractorProtocol, router: DashboardRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
    
    func viewDidLoadAsync() async {
//        Task{
            await fetchImages()
//        }
    }
    

    
// --------------------------------------------------------------------------
/*
        private func fetchImages() async {
            DispatchQueue.main.async {
                self.isLoading = true
            }
            do {
                let result = try await interactor.fetchImages()
                DispatchQueue.main.async {
                    self.images = result
                    self.isLoading = false
                }
            } catch {
                print("Error fetching images: \(error)")
                DispatchQueue.main.async {
                    self.isLoading = false
                }
            }
        }
 */
// ----------Just Add @MainActor and replace this code with following--------
// --------------------------------------------------------------------------
    
    @MainActor
    private func fetchImages() async {
        isLoading = true
        do {
            let result = try await interactor.fetchImages()
            images = result
        } catch {
            print("Error fetching images: \(error)")
        }
        isLoading = false
    }
    
    func loadImage(for url: String) async -> UIImage? {
        if let existing = imageCache[url] {
            return existing
        }
        
        let placeholder = UIImage(named: "placeholder_image")
        await MainActor.run {
            self.imageCache[url] = placeholder
            self.loadingImages.insert(url)
            self.failedImages.remove(url)
        }
        
        if let fetched = await interactor.fetchImage(for: url) {
            await MainActor.run {
                self.imageCache[url] = fetched
                self.loadingImages.remove(url)
            }
            return fetched
        }else{
            await MainActor.run{
                self.loadingImages.remove(url)
                self.failedImages.insert(url)
            }

            return placeholder
        }
    }

    func reloadImage(for url: String) async {
        failedImages.remove(url)
        imageCache.removeValue(forKey: url)
        await loadImage(for: url)
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
