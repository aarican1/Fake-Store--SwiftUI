//
//  MainTabView.swift
//  Fake Store
//
//  Created by Abdurrahman Arıcan on 20.05.2025.
//

import SwiftUI

struct MainTabView: View {
    @ObservedObject private var basketViewModel = BasketViewModel.shared
    @Environment(Router.self) private var router
    
    var body: some View {
        @Bindable var router = router
        TabView{
            //HOME
                HomeView()
                    .navigationDestination(for: Router.Destination.self) { destination in
                                            switch destination {
                                            case .signIn:
                                                // Navigate to Sign In if needed from Home (e.g., logout flow)
                                                SignInView()
                                            case .signUp:
                                                // Navigate to Sign Up if needed from Home
                                                SignUpView()
                                            case .home:
                                                // Navigating to home again might reset the tab's stack
                                                HomeView()
                                                
                                            case .productDetail(let product):
                                                // Handle product detail navigation from Home
                                                ProductDetailView(product: product)
                                                   
                                            case .mainTab:
                                                // MainTab is the container, navigating to it from within
                                                // a tab might not be the intended behavior.
                                                // Consider if this case is necessary here.
                                                 EmptyView() // Or handle appropriately
                                            }
                                        }
            .tabItem {
                Label("Home",systemImage: "house")
            }
            
            //BASKET
                BasketView()
                .navigationDestination(for: Router.Destination.self) { destination in
                    switch destination {
                    case .signIn:
                        // Navigate to Sign In
                        SignInView()
                    case .signUp:
                        // Navigate to Sign Up
                        SignUpView()
                    case .home:
                        // Navigating to home
                        HomeView()
                    case .productDetail(let product):
                        // Handle product detail
                        ProductDetailView(product: product)
                        
                    case .mainTab:
                        
                        EmptyView()
                    }
                }
                .tabItem {
                        Label("Basket",systemImage: "basket")
                }
                .badge(basketViewModel.products.count)
            
            //MYACCOUNT
            MyAccountView()
                    .navigationDestination(for: Router.Destination.self) { destination in
                                            switch destination {
                                            case .signIn:
                                                // Navigate to Sign In if needed from Home (e.g., logout flow)
                                                SignInView()
                                            case .signUp:
                                                // Navigate to Sign Up if needed from Home
                                                SignUpView()
                                            case .home:
                                                // Navigating to home again might reset the tab's stack
                                                HomeView()
                                            case .productDetail(let product):
                                                // Handle product detail navigation from Home
                                                ProductDetailView(product: product)
                                            case .mainTab:
                                                // MainTab is the container, navigating to it from within
                                                // a tab might not be the intended behavior.
                                                // Consider if this case is necessary here.
                                                 EmptyView() // Or handle appropriately
                                            }
                                        }
            .tabItem {
                Label("My Account",systemImage: "person")
            }
                
        }
        .navigationBarBackButtonHidden()
    }
      
}

#Preview {
    MainTabView()
        .environment(Router())
}
