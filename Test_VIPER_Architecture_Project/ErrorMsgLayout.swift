//
//  ErrorMsgLayout.swift
//  Test_VIPER_Architecture_Project
//
//  Created by Sai Krishna on 11/13/25.
//

import Foundation

import SwiftUI

struct ErrorMsgLayout: View {
    let message: String
    var onRetry: (() -> Void)? = nil
    
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.system(size: 50))
                .foregroundColor(.red)
            
            Text(message)
                .font(.body)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 24)
            
            if let onRetry = onRetry {
                Button(action: onRetry) {
                    Text("Retry")
                        .fontWeight(.semibold)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 10)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding(.top, 10)
            }
        }
    }
}

