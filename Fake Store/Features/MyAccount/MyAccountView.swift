//
//  MyAccountView.swift
//  Fake Store
//
//  Created by Abdurrahman Arıcan on 20.05.2025.
//

import SwiftUI

struct MyAccountView: View {
    var body: some View {
        VStack(alignment:.center,spacing: 24){
            UserInformationView(profile: mockProfile)
            
            
            VStack(spacing:16){
                AccountOptionView(title: "My Orders", image: "truck.box.badge.clock.fill") { }
                AccountOptionView(title: "My Comments", image: "star.bubble.fill") { }
                AccountOptionView(title: "Buy Again", image: "arrow.counterclockwise.circle.fill") { }
            }
            
            .background(Color.green.opacity(0.09))
            .cornerRadius(12)
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    MyAccountView()
}
