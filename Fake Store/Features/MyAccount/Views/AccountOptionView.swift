//
//  AccountOptionView.swift
//  Fake Store
//
//  Created by Abdurrahman Arıcan on 24.05.2025.
//

import SwiftUI

struct AccountOptionView: View {
    let title: String
    let image: String
    let action: () -> Void
    var body: some View {
        
        Button(action:action) {
            HStack(spacing: 24) {
                Image(systemName: image)
                    .foregroundStyle(Color.green)
                
                Text(title)
                    .font(.headline)
                    .foregroundStyle(Color.black)
                Spacer()
              
                    Image(systemName: "chevron.right")
                        .font(.headline)
                        .foregroundStyle(Color.green)
            }
            .padding()
        }

        
        
       
        
        
    }
}

#Preview {
    AccountOptionView(title: "Test", image: "truck.box.badge.clock.fill") {
        
    }
}
