//
//   BasketView.swift
//  Fake Store
//
//  Created by Abdurrahman Arıcan on 20.05.2025.
//

import SwiftUI

struct BasketView: View {
    @ObservedObject var viewModel = BasketViewModel.shared
    @Environment(Router.self) private var router
    @Binding var selectedTab: MainTabView.Tab
    
    
    var body: some View {
     @Bindable var router = router
        Spacer()
        Group {
            if viewModel.products.isEmpty {
                VStack(spacing: 36) {
                    Spacer()
                    Text("Basket is empty")
                    
                    Button {
                        selectedTab = .home
                    } label: {
                        Text("Go To Shop View")
                            .foregroundStyle(Color.white)
                            .padding()
                            .background(Color.green)
                            .cornerRadius(12)
                    }
                    Spacer()
                }
                

            } else {
                List {
                    ForEach(Array(viewModel.products.enumerated()),id:\.element){index,product in
                        AddedProductView(product: product) {
                            viewModel.removeProduct(at: index)
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
    }
}

#Preview {
    BasketView(selectedTab: .constant(.basket))
        .environment(Router())
}
