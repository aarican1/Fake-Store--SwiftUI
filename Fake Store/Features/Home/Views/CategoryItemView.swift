//
//  CategoryItemView.swift
//  Fake Store
//
//  Created by Abdurrahman Arıcan on 12.05.2025.
//

import SwiftUI

struct CategoryItemView: View {
    var category: Category
    var isSelected:Bool
    var action: () -> Void
    var body: some View {
        Button(action: action) {
            Text(category.name)
                .foregroundStyle(Color.primary)
                .padding(.horizontal,12)
                .padding(.vertical,8)
               
                
        }
        .overlay(RoundedRectangle(cornerRadius: 24).stroke(Color.primary,lineWidth: 1))
        .background(isSelected ? Color.green : Color.clear)
        .cornerRadius(24)
    }
}

#Preview {
    CategoryItemView(category: mockCategory, isSelected: false){
        print("test")
    }
}
