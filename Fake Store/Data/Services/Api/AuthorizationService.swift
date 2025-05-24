//
//  AuthorizationService.swift
//  Fake Store
//
//  Created by Abdurrahman Arıcan on 7.05.2025.
//

import Foundation
import Alamofire

final class AuthorizationService{
    
    static let shared = AuthorizationService()
    private let network = NetworkService.shared
    
    enum EndPoint: String{
        case signIn  =  "/auth/login"
       // case signUp  = "/auth/sign"
     }
    
    

    
    private init(){}
    
    func signIn(requestModel: SignInRequestModel, completion: @escaping (Result<SignInResponseModel, AFError>) -> Void) {
        let parameters: [String: Any] = [
            "email": requestModel.email,
            "password": requestModel.password
        ]
        network.request(endPoint: EndPoint.signIn.rawValue, method: .post, parameters: parameters, completion: completion)
    }
}
