//
//  CustomToasts.swift
//  Fake Store
//
//  Created by Abdurrahman Arıcan on 11.05.2025.
//

import SwiftUI

struct CustomToasts: View {
    let message: String
    var body: some View {
           Text(message)
               .padding()
               .foregroundColor(.white)
               .background(Color.black.opacity(0.7))
               .cornerRadius(10)
               .padding(.horizontal)
       }
}

#Preview {
    CustomToasts(message: "Your account created succesfully.")
}
