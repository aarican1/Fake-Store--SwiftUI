//
//  MyAccountView.swift
//  Fake Store
//
//  Created by Abdurrahman Arıcan on 20.05.2025.
//

import SwiftUI

struct MyAccountView: View {
    @ObservedObject var viewModel  = MyAccountViewModel()
    @Environment(Router.self) private var router
    @Binding var selectedTab: MainTabView.Tab
    
    
    var body: some View {
        @Bindable var router = router
        Group{
            if viewModel.isLoading || viewModel.profile == nil {
                VStack {
                    ProgressView()
                        .foregroundStyle(Color.green)
                    Text("Loading")
                        .foregroundStyle(Color.green)
                }
            }
            else{
                VStack(alignment:.center,spacing: 24){
                    
                    UserInformationView(profile: viewModel.profile!)
                    
                    VStack(spacing:16){
                        AccountOptionView(title: "My Orders", image: "truck.box.badge.clock.fill") { }
                        AccountOptionView(title: "My Comments", image: "star.bubble.fill") { }
                        AccountOptionView(title: "Buy Again", image: "arrow.counterclockwise.circle.fill") { }
                    }
                    .background(Color.green.opacity(0.09))
                    .cornerRadius(12)
                    
                    Spacer()
                }
            }
        }
        .alert(item:$viewModel.alertItem) {alertItem in
            Alert(title: alertItem.title,message: alertItem.message,dismissButton: alertItem.dismissButton)
        }
        .onChange(of: viewModel.isExpiredToken, { oldValue, newValue in
            if newValue == true {
                router.setRoot(to:.signIn)
            }
        })
        .onAppear {
     
            Task{
                await viewModel.getProfile()
            }
        }
        
        .padding()
    }
}

#Preview {
    MyAccountView(selectedTab: .constant(.myAccount))
        .environment(Router())
}
