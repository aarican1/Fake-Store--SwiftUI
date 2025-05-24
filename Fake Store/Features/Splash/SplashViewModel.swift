//
//  SplashViewModel.swift
//  Fake Store
//
//  Created by Abdurrahman Arıcan on 21.05.2025.
//

import Foundation

final class SplashViewModel:ObservableObject {
    @Published var isloggedIn:Bool = false
    
    private var authService = AuthorizationService.shared
    
    
    
    @MainActor
    func checkLoginStatus() async {
        
        do{
            let _ : ProfileResponseModel =   try await  authService.getProfile()
           
            isloggedIn = true
            }
        catch{
            isloggedIn = false
            }
        
        }
    
}
