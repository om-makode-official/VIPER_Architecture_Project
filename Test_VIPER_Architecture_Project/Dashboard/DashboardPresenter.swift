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
