//
//  ProductsView.swift
//  Fake Store
//
//  Created by Abdurrahman Arıcan on 16.05.2025.
//

import SwiftUI

struct ProductsView: View {
    @ObservedObject var viewModel : HomeViewModel
    var body: some View {
        ScrollView(.vertical,showsIndicators:false) {
            LazyVGrid(columns:Array(repeating: GridItem(.flexible(),spacing: 16), count: 3))
            {
                ForEach(viewModel.shownProducts,id:\.self){ product in
                    ProductItemView(product: product,action: {
                        print("product id  : \(product.id)")
                    })
                         .frame(height:300)
                }
            }
        }
    }
}

#Preview {
    ProductsView(viewModel: HomeViewModel())
}
