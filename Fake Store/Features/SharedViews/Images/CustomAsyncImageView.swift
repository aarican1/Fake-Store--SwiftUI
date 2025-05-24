//
//  CustomAsyncImageView.swift
//  Fake Store
//
//  Created by Abdurrahman Arıcan on 16.05.2025.
//

import SwiftUI

struct CustomAsyncImageView: View {
    var url : String?
    var body: some View {
        AsyncImage(url: URL(string: url ?? "https://placehold.co/600x400" )){phase in
            switch phase {
            case .empty:
                ProgressView()
                   // .frame(width:115, height: 200)
                   // .aspectRatio(9/16, contentMode: .fit)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
                
            case .success(let image):
                image
                    .resizable()
                   // .frame(width:115, height: 200)
                    //.aspectRatio(9/16, contentMode: .fit)
                    .cornerRadius(8)
                
            case .failure(_):
                Image(systemName: "photo.on.rectangle.angled")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.gray)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
        
            @unknown default:
                EmptyView()
                   // .frame(width:115, height: 200)
                }
            }
    }
}

#Preview {
    CustomAsyncImageView(url:"https://placehold.co/600x400")
}
