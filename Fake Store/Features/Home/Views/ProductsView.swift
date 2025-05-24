//
//  ProductsView.swift
//  Fake Store
//
//  Created by Abdurrahman Arıcan on 16.05.2025.
//

import SwiftUI

struct ProductsView: View {
    @ObservedObject var viewModel : HomeViewModel
    @Environment(Router.self) private var router
    var body: some View {
        @Bindable var router = router
        ScrollView(.vertical,showsIndicators:false) {
            LazyVGrid(columns:Array(repeating: GridItem(.flexible(),spacing: 16), count: 3))
            {
                ForEach(viewModel.shownProducts,id:\.self){ product in
                    ProductItemView(product: product,action: {
                        print(product.title)
                        router.navigate(to: .productDetail(product: product))
                    }
                                    
                    
                    )
                         .frame(height:300)
                        
                }
            }
        }
       
    }
}

#Preview {
    ProductsView(viewModel: HomeViewModel())
        .environment(Router())
}
