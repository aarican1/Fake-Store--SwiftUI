//
//  MyAccountViewModel.swift
//  Fake Store
//
//  Created by Abdurrahman Arıcan on 25.05.2025.
//

import Foundation

final class MyAccountViewModel : ObservableObject {
    private var authenticationService  = AuthorizationService.shared
    
    @Published var isLoading : Bool = false
    @Published var profile : ProfileResponseModel?
    @Published var isExpiredToken : Bool =  false
    @Published var alertItem  : AlertItem?
    
    
    func getProfile() async {
        do{
            isLoading = true
            let response = try await authenticationService.getProfile()
            print(response)
            profile = response
            isLoading = false
        }
        catch let error as ErrorModel {
            if  error.statusCode == 401 {
                isExpiredToken = true
                alertItem = AlertItem.createAlert(title:error.title, message: error.message)
                isLoading = false
            }
        }
        catch {
            alertItem = AlertItem.createAlert(title: "Error", message: "Something went wrong. Please try again later.")
            isLoading = false
        }
    }
}
