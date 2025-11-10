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
                if presenter.isLoading {
                    ProgressView("Loadinggggg...")
                        .padding()
                } else {
                    ScrollView {
                        LazyVStack {
                            ForEach(presenter.images) { image in
                                VStack {
                                    AsyncImage(url: URL(string: image.download_url)) { phase in
                                        
                                        if let img = phase.image { img
                                                .resizable()
                                                .scaledToFit()
                                                .cornerRadius(12)
                                                .padding()
                                            
                                        }
                                        else if phase.error != nil {
                                            Text("Error loading image")
                                                .foregroundColor(.red)
                                            
                                        }
                                        else {
                                            ProgressView()
                                        }
                                    }
                                    Text(image.author)
                                        .font(.subheadline)
                                        
                                }
                            }
                        }
                    }
                }
            }
            .onAppear {
                presenter.viewDidLoad()
            }
            .navigationTitle("Random Images")
        }
}
