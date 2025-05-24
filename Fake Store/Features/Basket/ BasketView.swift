//
//   BasketView.swift
//  Fake Store
//
//  Created by Abdurrahman Arıcan on 20.05.2025.
//

import SwiftUI

struct BasketView: View {
    @ObservedObject var viewModel = BasketViewModel.shared
    var body: some View {
        Spacer()
        Group {
            if viewModel.products.isEmpty {
                Text("Basket is empty")
            } else {
                List {
                    ForEach(Array(viewModel.products.enumerated()),id:\.element){index,product in
                        AddedProductView(product: product) {
                            viewModel.removeProduct(at: index)
                        }
                    }
                }
            }
        }
        Spacer()
        
        HStack(spacing:16) {
            Text("Total Price : $\(viewModel.totalPrice,format: .number.precision(.fractionLength(2)))")
                .font(.title3)

            
            Button{
                
            }label:{
                Text("Confirm Basket")
                    .font(.title2)
                    .lineLimit(1)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(12)
            }
        }
        .padding()
            
       
    }
}

#Preview {
    BasketView()
}
