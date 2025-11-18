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
            ToolbarItem(placement: .navigationBarLeading){
                Button("Add Image"){
                    presenter.openProfileSheet()
                }
            }
        }
        .sheet(isPresented: $presenter.showProfileSheet) {
            profileView()
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
            ProgressView("Loading Images...")
            
        case .loaded( let randomImageData):
            self.loadedView(randomImages: randomImageData)
            
        case .error(let errorMsg, let showRetry):
            ErrorMsgLayout(message: errorMsg, onRetry: showRetry ? {
                presenter.loadingStates = .idle
            } : nil)
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
                
            }, placeholder: {
                ZStack {
                    Image("placeholder_image")
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(12)
                        .padding()
                        .frame(height: 300)
                    
                    ProgressView()
                }
                
            })
            Text(randomImage.author)
        }
    }
}

// MARK: - New Added Images(sheet)

extension DashboardView{

    func profileView() -> some View {
        NavigationStack {
            Form {
                TextField("Enter Author Name", text: $presenter.name)
                TextField("Enter Image URL", text: $presenter.imageURL)
            }
            .navigationTitle("Add Image")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        presenter.saveImage()
                    }
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        presenter.dismissSheet()
                    }
                }
            }
            .alert(item: $presenter.alertMessage){ msg in
                Alert(title: Text(msg.title),
                      message: Text(msg.message),
                      dismissButton: .default(Text("OK")){
                    
                    if case .success = msg{
                        presenter.alertMessage = nil
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                            
                            presenter.returnData()
                            
                        }
                    }
                })
            }
            
        }
        
    }
    
}
