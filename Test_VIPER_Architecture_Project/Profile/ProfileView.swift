//
//  ProfileView.swift
//  Test_VIPER_Architecture_Project
//
//  Created by Sai Krishna on 11/14/25.
//

import SwiftUI

struct ProfileView: View {
    
    @StateObject private var presenter: ProfilePresenter
    
    init(presenter: ProfilePresenter) {
        self._presenter = StateObject(wrappedValue: presenter)
    }
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Enter Author Name", text: $presenter.name)
                TextField("Enter Image URL", text: $presenter.imageURL)
            }
            .navigationTitle("Add Image")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        presenter.saveImage()
                    }
                }
                
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        presenter.dismiss()
                    }
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
            }
            
            )
        }
    }
}
