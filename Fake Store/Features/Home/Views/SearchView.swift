//
//  SearchView.swift
//  Fake Store
//
//  Created by Abdurrahman Arıcan on 12.05.2025.
//

import SwiftUI

struct SearchView: View {
    @Binding var text:String
    var body: some View {
        HStack{
            Image(systemName: "magnifyingglass")
                               .foregroundColor(.black)
            
            TextField("Search...", text:$text)
                .padding()
        }
            .padding(10)
            .cornerRadius(12)
            .padding(.horizontal)
            .frame(height: 56)
            .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.black, lineWidth: 1))
    }
}

#Preview {
    SearchView(text: .constant("test"))
}
