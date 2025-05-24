//
//  ProductDetailView.swift
//  Fake Store
//
//  Created by Abdurrahman Arıcan on 16.05.2025.
//

import SwiftUI

struct ProductDetailView: View {
    @ObservedObject var basketViewModel = BasketViewModel.shared
    @State private var isAddedToBasket: Bool = false
    @Environment(Router.self) private var router
    var product: Product
    var body: some View {
        @Bindable var router = router
        VStack(alignment: .leading,spacing: 16){
            ProductImageView(images: product.images)
                .frame(maxHeight:400)
            
            HStack {
                Text(product.title)
                    .font(.headline)
                Spacer()
                Text("$\(product.price)")
                    .font(.headline)
                    .foregroundStyle(.green)
                    .padding(.horizontal,36)
            }
            
            Text(product.description)
                .font(.caption)
            
            Text(product.category.name)
                .font(.caption2)
                .padding(5)
                .background(.blue)
                .cornerRadius(12)
            
            HStack{
                Spacer()
                Button {
                    if(!isAddedToBasket){
                        isAddedToBasket =   basketViewModel.addProduct(product: product)
                        router.navigateBack()
                    }
                    
                } label: {
                    Text(isAddedToBasket ?"Added to Basket" : "Add Basket")
                        .font(.title2)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: 200)
                        .background(.green)
                        .cornerRadius(12)

                }
                .disabled(isAddedToBasket)

            }
        }
        .padding()
    }
}

#Preview {
    ProductDetailView(product:mockProduct)
        .environmentObject(Router())
}
