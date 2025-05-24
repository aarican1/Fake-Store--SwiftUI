//
//  SignUpViewModel.swift
//  Fake Store
//
//  Created by Abdurrahman Arıcan on 11.05.2025.
//

import Foundation


final class SignUpViewModel:ObservableObject {
    @Published var requestModel : SignUpRequestModel =  SignUpRequestModel(name:"", email: "", password: "",avatar: "https://picsum.photos/800")
    @Published var nameError : String = ""
    @Published var emailError : String = ""
    @Published var passwordError : String = ""
    @Published var showAlert : Bool = false
    @Published var isLoading : Bool = false
    @Published var alertItem  : AlertItem?
    @Published var isSignUp : Bool = false
    @Published var isShowingToast : Bool = false
    private let service :AuthorizationService = AuthorizationService.shared
    
    
    func validName(){
        if  !requestModel.name.isEmpty && (requestModel.name.count) < 3 {
            nameError = "Please enter valid name."
            return
        }
        else{
            nameError = ""
            return
        }
    }
    
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
    func signUp() async {
         print("içerdeyim")
        guard validateForm()else { return }
            
        do {
            print("Encoded Request Body: \(requestModel.debugJSONString())")
            isLoading = true
          print("service")
            let response = try await  service.signUp(requestModel: requestModel)
            print(response)
            isLoading = false
            isSignUp = true
            isShowingToast = true
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


extension Encodable {
    func debugJSONString() -> String {
        let encoder = JSONEncoder()
        // encoder.outputFormatting = .prettyPrinted // Konsolda daha okunur olması için (isteğe bağlı)
        guard let jsonData = try? encoder.encode(self) else {
            return "JSON Encoding Failed" // Encoding hatası
        }
        return String(data: jsonData, encoding: .utf8) ?? "JSON Data to String Conversion Failed" // String'e çevirme hatası
    }
}
