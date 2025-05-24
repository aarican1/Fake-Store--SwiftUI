//
//  CategoriesView.swift
//  Fake Store
//
//  Created by Abdurrahman Arıcan on 16.05.2025.
//

import SwiftUI

struct CategoriesView: View {
    @ObservedObject var viewModel: HomeViewModel
    var body: some View {
        ScrollView(.horizontal,showsIndicators: false) {
            LazyHStack(spacing:12) {
                ForEach(viewModel.categories,id:\.self) { category in
                    let isSelected = viewModel.selectedCategory == category
                    CategoryItemView(category: category, isSelected:isSelected) {
                        Task{
                            if isSelected {
                                viewModel.selectedCategory = nil
                                await viewModel.getProducts()
                            } else {
                                viewModel.selectedCategory = category
                                await viewModel.filterProductsByCategory(by: category)
                            }
                        }
                    }
                    
                }
            }
        }
    }
}

#Preview {
    CategoriesView(viewModel: HomeViewModel())
}
