//
//  DashboardView.swift
//  Test_VIPER_Architecture_Project
//
//  Created by Sai Krishna on 11/7/25.
//

import Foundation
import SwiftUI

struct DashboardView: View {
    @StateObject private var presenter: DashboardPresenter
    
    init(presenter: DashboardPresenter) {
        _presenter = StateObject(wrappedValue: presenter)
    }
    
    var body: some View {
        VStack {
            
            Text(presenter.welcomeMessage)
                .font(.title)
                .padding()
        }
        .onAppear {
            presenter.viewDidLoad()
        }
    }
}
