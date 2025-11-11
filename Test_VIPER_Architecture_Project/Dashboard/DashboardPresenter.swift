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
    
    private let interactor: DashboardInteractorProtocol
    private let router: DashboardRouterProtocol
    
    init(interactor: DashboardInteractorProtocol, router: DashboardRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
    
    func viewDidLoad() {
        Task {
            await fetchImages()
        }
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
        
        if let fetched = await interactor.fetchImage(for: url) {
            await MainActor.run {
                self.imageCache[url] = fetched
            }
            return fetched
        }
        return nil
    }
    
    func logout(){
        let defaults = UserDefaults.standard
        defaults.set(false, forKey: "isLoggedIn")
        defaults.removeObject(forKey: "loggedInUserEmail")
        
        router.navigateToLogin()
    }


}
