//
//  AddedProductView.swift
//  Fake Store
//
//  Created by Abdurrahman Arıcan on 22.05.2025.
//

import SwiftUI

struct AddedProductView: View {
    let product: Product
    let action: () -> Void
    var body: some View {
        HStack(spacing: 16){
            CustomAsyncImageView(url: product.images.first)
                .frame(maxWidth: 72,maxHeight: 128)

            
            VStack(alignment: .leading){
                HStack {
                    Text(product.title)
                        .font(.title)
                        .lineLimit(2)
                        
                    
                    Spacer()
                    Button {
                    action()
                    } label: {
                        Image(systemName: "trash.fill")
                            .foregroundColor(.gray)
                    }
                  

                }
                
                HStack {
                    Image(systemName:"truck.box.fill")
                        .resizable()
                        .frame(width: 16,height: 16)
                        .foregroundColor(.green)
                    Text("Will be shipped tomorrow at the latest")
                        .font(.caption2)
                        .lineLimit(1)
                        .fixedSize()
                }
                HStack{
                    Spacer()
                    
                    Text("$\(product.price)")
                        .font(.title2)
                        .foregroundColor(.green)
                }
            }
        }
        .padding(24)
    }
}

#Preview {
    AddedProductView(product: mockProduct) {
        print(" Remove action tapped" )
    }
}
