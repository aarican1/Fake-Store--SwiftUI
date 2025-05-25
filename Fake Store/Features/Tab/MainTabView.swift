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
    
    @State private var selectedTab:Tab  =  .home
    
    enum Tab: Hashable{
        case home
        case basket
        case myAccount
    }
    
    var body: some View {
        @Bindable var router = router
        TabView(selection:$selectedTab){
            
            
            //HOME
                HomeView(selectedTab: $selectedTab)
                    .navigationDestination(for: Router.Destination.self) { destination in
                            switch destination {
                                case .signIn:
                                    SignInView()
                                    
                                case .signUp:
                                    SignUpView()
                                
                                case .mainTab:
                                    EmptyView()
                                
                                case .productDetail(product: let product):
                                    ProductDetailView(product:product)
                            }
                                        }
            .tabItem {
                Label("Home",systemImage: "house")
            }
            .tag(Tab.home)
            
            
            //BASKET
                BasketView(selectedTab: $selectedTab)
                .environment(router)
                .navigationDestination(for: Router.Destination.self) { destination in
                    switch destination {
                        case .signIn:
                            SignInView()
                            
                        case .signUp:
                            SignUpView()

                        case .mainTab:
                            EmptyView()
                        
                        case .productDetail(product: let product):
                            ProductDetailView(product:product)
                    }
                }
                .tabItem {
                        Label("Basket",systemImage: "basket")
                }
                .badge(basketViewModel.products.count)
                .tag(Tab.basket)
            
            
            //MYACCOUNT
            MyAccountView(selectedTab: $selectedTab)
                    .navigationDestination(for: Router.Destination.self) { destination in
                                switch destination {
                                    case .signIn:
                                        SignInView()
                                        
                                    case .signUp:
                                        SignUpView()
            
                                    case .mainTab:
                                        EmptyView()
                                    
                                    case .productDetail(product: let product):
                                        ProductDetailView(product:product)
                                    }
                                }
            .tabItem {
                Label("My Account",systemImage: "person")
            }
            .tag(Tab.myAccount)
                
        }
        .environment(router)
        .navigationBarBackButtonHidden()
    }
      
}

#Preview {
    MainTabView()
        .environment(Router())
}
