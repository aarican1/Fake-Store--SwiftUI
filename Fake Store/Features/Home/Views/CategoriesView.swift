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
                    //MARK: fix me
                    CategoryItemView(category: category, isSelected: viewModel.selectedCategory == category) {
                        Task{
                            await viewModel.filterProductsByCategory(by: category)
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
