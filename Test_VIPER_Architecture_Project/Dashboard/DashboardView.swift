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
                                    
/*
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
                                     
*/
                                    
                                    if let cachedImg = presenter.imageCache[image.download_url] {
                                        Image(uiImage: cachedImg)
                                            .resizable()
                                            .scaledToFit()
                                            .cornerRadius(12)
                                            .padding()
                                            .frame(height: 300)
                                            
                                    } else {
                                        ProgressView()
                                            .task {
                                                if let newImage = await presenter.loadImage(for: image.download_url) {
                                                    presenter.imageCache[image.download_url] = newImage
                                                }
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
            .navigationBarBackButtonHidden()
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    Button("Logout"){
                        
                        presenter.logout()
                    }
                }
            }
            
        }
}
