//
//  HomeView.swift
//  Fake Store
//
//  Created by Abdurrahman Arıcan on 10.05.2025.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel = HomeViewModel()
    @Environment(Router.self) private var router
    @Binding var selectedTab: MainTabView.Tab
    
    
    var body: some View {
        @Bindable var router = router
        
        Group{
            if viewModel.isLoading{
                ProgressView()
                    .scaleEffect(2)
            } else{
                VStack{
                    SearchView(text:$viewModel.searchText )
                        .onSubmit {
                            Task{
                                await viewModel.filterProductsByTitle()
                            }
                        }
                    
                    CategoriesView(viewModel: viewModel)
                        .frame(height: 56)
                    
                    ProductsView(viewModel: viewModel)
                        .frame(maxHeight:.infinity)
                }
                .padding(.horizontal)
            }
        }.onAppear{
            Task{
                await viewModel.getCategories()
                await viewModel.getProducts()
            }
        }
        .navigationBarBackButtonHidden()
    }
    
      
        
}

#Preview {
    HomeView(selectedTab: .constant(.home))
        .environment(Router())
}
