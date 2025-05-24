//
//  ProductItemView.swift
//  Fake Store
//
//  Created by Abdurrahman Arıcan on 13.05.2025.
//

import SwiftUI

struct ProductItemView: View {
    var product: Product
    let action : () -> Void
    var body: some View {
        
            VStack(alignment:.leading ,spacing: 12){
                AsyncImage(url: URL(string: product.images.first ?? "https://placehold.co/600x400" )){phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(width:115, height: 200)
                            .aspectRatio(9/16, contentMode: .fit)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(8)
                        
                    case .success(let image):
                        image
                            .resizable()
                            .frame(width:115, height: 200)
                            //.aspectRatio(9/16, contentMode: .fit)
                            .cornerRadius(8)
                        
                    case .failure(_):
                        Image(systemName: "photo.on.rectangle.angled")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width:115, height: 200)
                                .foregroundColor(.gray)
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(8)
                
                    @unknown default:
                        EmptyView()
                            .frame(width:115, height: 200)
                        }
                    }
            
                   
                
                Text(product.title)
                    .font(.headline)
                
                Text("$\(product.price)")
                    .font(.callout)
                
                
            }
            .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.primary.opacity(0.2),lineWidth:0))
            .aspectRatio(9/16,contentMode: .fit)
            .contentShape(Rectangle())
            .onTapGesture(perform: action)
           
        
    }
}

#Preview {
    ProductItemView(product: Product(id: 1, title: "Test", slug: "Test", price: 120, description: "Test", category: mockCategory, images: ["https://placehold.co/600x400"], creationAt: "https://placehold.co/600x400", updatedAt: "String")) {

    }
}
