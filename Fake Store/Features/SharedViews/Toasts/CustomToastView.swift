//
//  CustomToastView.swift
//  Fake Store
//
//  Created by Abdurrahman Arıcan on 11.05.2025.
//

import SwiftUI

struct CustomToastView: View {
    let message: String
    var body: some View {
           Text(message)
               .padding()
               .lineLimit(nil)
               .foregroundColor(.white)
               .background(Color.green.opacity(1))
               .cornerRadius(12)
               .frame(maxWidth: .infinity)
               .padding(.horizontal,12)
       }
}

#Preview {
    CustomToastView(message: "Your account created succesfully." )
}
