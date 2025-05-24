//
//  SplashView.swift
//  Fake Store
//
//  Created by Abdurrahman Arıcan on 19.05.2025.
//

import SwiftUI

struct SplashView: View {
    @ObservedObject var viewModel = SplashViewModel()
    @Environment(Router.self) private var router
    var body: some View {
        @Bindable var router = router
        NavigationStack(path: $router.navigationPath) {
            Image("ic")
                .resizable()
                .frame(width: 200,height: 200)
                .navigationDestination(for: Router.Destination.self) { destination in
                    switch destination {
                        case .signUp:
                            SignUpView()
                        
                        case .home:
                            HomeView(
                            )
                    case .mainTab:
                        MainTabView()
                        
                        case .signIn:
                            SignInView()
                        
                    case .productDetail(let product):
                        ProductDetailView(product:product)
                    }
                
            }
        }
        .onAppear {
            
            Task {
                await viewModel.checkLoginStatus()
            
                if(viewModel.isloggedIn){
                    router.setRoot(to: .mainTab)
                }
                else{
                    router.setRoot(to: .signIn)
                }
            }
            
        }
      
    }
}

#Preview {
    SplashView()
        .environment(Router())
}
