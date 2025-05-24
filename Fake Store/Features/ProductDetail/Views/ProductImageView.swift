//
//  ProductImageView.swift
//  Fake Store
//
//  Created by Abdurrahman Arıcan on 16.05.2025.
//

import SwiftUI

struct ProductImageView: View {
    let images : [String?]
    @State private var currentImage = 0
    var body: some View {
        ZStack {
            TabView(selection: $currentImage){
                ForEach(images.indices, id:\.self){ index in
                    CustomAsyncImageView(url:images[index])
                        .tag(index)
                }
            }
            .tabViewStyle(.page)
            .indexViewStyle(.page)
            
            
        }
    }
}

#Preview {
    ProductImageView(images: ["https://placehold.co/600x400","https://picsum.photos/200/300"])
}
