//
//  SignInViewModel.swift
//  Fake Store
//
//  Created by Abdurrahman Arıcan on 6.05.2025.
//

import Foundation
import SwiftUI

final class SignInViewModel:ObservableObject {
    @Published var requestModel : SignInRequestModel =  SignInRequestModel(email: "", password: "")
    @Published var emailError : String = ""
    @Published var passwordError : String = ""
    @Published var showAlert : Bool = false
    @Published var isLoading : Bool = false
    @Published var alertItem  : AlertItem?
    @Published var isSignIn : Bool = false
    private let service :AuthorizationService = AuthorizationService.shared
    
    func validEmail(){
        if  !requestModel.email.isEmpty && !requestModel.email.isValidEmail {
            emailError = "Please enter valid email address."
            return
        }
        else{
            emailError = ""
            return 
        }
    }
    
    func validPassword(){
        print(!requestModel.password.isEmpty && requestModel.password.count < 6)
        print(requestModel.password)
        if !requestModel.password.isEmpty && requestModel.password.count < 6 {
            passwordError = "Password must be at least 6 characters."
            return
        }else{
            passwordError = ""
        return
        }
    }
    
    private func validateForm() -> Bool{
        validEmail()
        validPassword()
        if emailError.isEmpty && passwordError.isEmpty {
            return true
        }
            return false
    }
    
    @MainActor
    func signIn() async {
       
        guard validateForm()else { return }
            
        do {
            isLoading = true
          let response = try await  service.signIn(requestModel: requestModel)
            isLoading = false
            isSignIn = true
        }
        catch  let error as ErrorModel {
            if error.statusCode == 401 {
                alertItem = AlertItem.createAlert(title:error.title, message: error.message,)
                isLoading = false
            }
        }
        catch {
            alertItem = AlertItem.createAlert(title: "Error", message: "Something went wrong. Please try again later.")
            isLoading = false
        }
           
    }
}
