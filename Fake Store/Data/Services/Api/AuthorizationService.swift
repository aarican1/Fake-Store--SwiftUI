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
    private let keychainService = KeychainService.shared
    
    
    enum EndPoint: String{
        case signIn  =  "auth/login"
        case signUp  = "users/"
        case getProfile = "auth/profile"
        case refreshAccessToken  = "auth/refresh-token"
     }
    
    
    private init(){}
    
    
    func signIn(requestModel: SignInRequestModel) async throws -> SignInResponseModel {
       
        let response : SignInResponseModel =  try await network.request(endPoint: EndPoint.signIn.rawValue, method: .post, parameters: requestModel, headers: nil,)
        
        try  keychainService.save(for: KeychainService.AuthKey.accessToken.rawValue, response.accessToken)
        try  keychainService.save(for: KeychainService.AuthKey.refreshToken.rawValue, response.refreshToken)
        return response
    }
    
    
    func signUp(requestModel: SignUpRequestModel) async throws -> SignUpResponseModel {
       
        let response : SignUpResponseModel =  try await network.request(endPoint: EndPoint.signUp.rawValue, method: .post, parameters: requestModel, headers: ["Content-Type" :"application/json" ,"Accept": "application/json"],)
        
        
        return response
    }
    
    
    
    func getProfile() async throws -> ProfileResponseModel {
        
        do {
            guard let accessToken : String  =  try  keychainService.read(for:KeychainService.AuthKey.accessToken.rawValue) else{   throw ErrorModel(title: "Token Error", message: "No access token found.", statusCode: 401)}
            
            let response : ProfileResponseModel = try await network.request(endPoint:  EndPoint.getProfile.rawValue,method: .get, headers: ["Authorization" : "Bearer \(accessToken)"] )
            
            return response
        }
        catch let error as ErrorModel {
            if error.statusCode == 401 {
                try await refreshAccessToken()
                return try await getProfile()
            }
            throw error
        }
    }
    
    
    
    private func refreshAccessToken() async throws {
      
        guard let refreshToken = try? keychainService.read(for: KeychainService.AuthKey.refreshToken.rawValue) else {
            throw ErrorModel(title: "Token Error", message: "No refresh token found.", statusCode: 401)
        }
         
        let response : RefreshAccessTokenResponseModel = try await network.request(endPoint: EndPoint.refreshAccessToken.rawValue,method: .post, parameters:[ RefreshAccessTokenRequest(refreshToken: refreshToken)
        ], headers: ["Content-Type":" application/json"])
        
     
        try  keychainService.save(for: KeychainService.AuthKey.accessToken.rawValue, response.accessToken)
        try  keychainService.save(for: KeychainService.AuthKey.refreshToken.rawValue, response.refreshToken)
    }
    
}
