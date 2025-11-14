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
    @State private var hasLoadedOnce = false
    
    init(presenter: DashboardPresenter) {
        _presenter = StateObject(wrappedValue: presenter)
    }
    
    var body: some View {
        ZStack {
            mainView()
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
    
    @ViewBuilder
    func mainView() -> some View {
        switch presenter.loadingStates {
        case .idle:
            Color.white.onAppear {
                presenter.loadImagesFrommWeb()
            }
        case .loading:
            ProgressView()
        case .loaded( let randomImageData):
            self.loadedView(randomImages: randomImageData)
        case .error(let errorMsg, let showRetry):
            ErrorMsgLayout(message: errorMsg, onRetry: showRetry ? {
                presenter.loadingStates = .idle
            } : nil)
            EmptyView()
        }
    }
    
    func loadedView(randomImages: [RandomImage]) -> some View {
        ScrollView {
            VStack {
                ForEach(randomImages, id: \.id) {
                    eachImage in
                    self.randomImageView(randomImage: eachImage)
                }
            }
        }
    }
    
    func randomImageView(randomImage: RandomImage ) -> some View {
        VStack {
            AsyncImage(url: URL(string: randomImage.download_url), content: {
                image in
                image
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(12)
                    .padding()
                    .frame(height: 300)
                Text(randomImage.author)
            }, placeholder: {
                Image("placeholder_image")
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(12)
                    .padding()
                    .frame(height: 300)
                    
            })
        }
    }
    
}
