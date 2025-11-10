//
//  DashboardPresenter.swift
//  Test_VIPER_Architecture_Project
//
//  Created by Sai Krishna on 11/7/25.
//

import Foundation

protocol DashboardViewToPresenterProtocol: AnyObject {
    func viewDidLoad()
}


class DashboardPresenter: ObservableObject, DashboardViewToPresenterProtocol {
    
    @Published var images: [RandomImage] = []
    @Published var isLoading = false
    
    private let interactor: DashboardInteractorProtocol
    
    init(interactor: DashboardInteractorProtocol) {
        self.interactor = interactor
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

}
