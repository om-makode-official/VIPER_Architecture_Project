////
////  DashboardPresenter.swift
////  Test_VIPER_Architecture_Project
////
////  Created by Sai Krishna on 11/7/25.
////
//
//import Foundation
//import UIKit
//
//
//class DashboardPresenter: ObservableObject, DashboardViewToPresenterProtocol {
//    
//    @Published var images: [RandomImage] = []
//    @Published var imageCache: [String: UIImage] = [:]
//    @Published var isLoading = false
//    
//    private let interactor: DashboardInteractorProtocol
//    private let router: DashboardRouterProtocol
//    
//    init(interactor: DashboardInteractorProtocol, router: DashboardRouterProtocol) {
//        self.interactor = interactor
//        self.router = router
//    }
//    
//    func viewDidLoad() {
//        Task {
//            await fetchImages()
//        }
//    }
//    
//    // MARK: - Fetch All Images
//    @MainActor
//    private func fetchImages() async {
//        isLoading = true
//        do {
//            let result = try await interactor.fetchImages()
//            images = result
//        } catch {
//            print("Error fetching images: \(error)")
//        }
//        isLoading = false
//    }
//    
//    // MARK: - Load Single Image with Placeholder + Auto Retry
//    func loadImage(for url: String) async -> UIImage? {
//        if let existing = imageCache[url] {
//            return existing
//        }
//        
//        // Try fetching image
//        if let fetched = await interactor.fetchImage(for: url) {
//            await MainActor.run {
//                self.imageCache[url] = fetched
//            }
//            return fetched
//        } else {
//            // Show placeholder first
//            let placeholder = UIImage(named: "placeholder_image")
//            await MainActor.run {
//                self.imageCache[url] = placeholder
//            }
//            
//            // 🔁 Auto retry after delay (3 seconds)
//            Task {
//                try? await Task.sleep(nanoseconds: 3_000_000_000) // 3 sec
//                await self.reloadImage(for: url)
//            }
//            
//            return placeholder
//        }
//    }
//    
//    // MARK: - Manual or Automatic Reload
//    func reloadImage(for url: String) async {
//        // Clear cache entries
//        interactor.clearCache(for: url)
//        await MainActor.run {
//            self.imageCache[url] = UIImage(named: "placeholder_image")
//        }
//        
//        if let newImage = await interactor.fetchImage(for: url) {
//            await MainActor.run {
//                self.imageCache[url] = newImage
//            }
//        } else {
//            print("❌ Reload failed for: \(url)")
//        }
//    }
//    
//    // MARK: - Logout
//    func logout() {
//        let defaults = UserDefaults.standard
//        defaults.set(false, forKey: "isLoggedIn")
//        defaults.removeObject(forKey: "loggedInUserEmail")
//        
//        router.navigateToLogin()
//    }
//}
