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
    
    @Published var welcomeMessage = ""
    
    func viewDidLoad() {
        welcomeMessage = "Welcome to Dashboard"
    }
}
