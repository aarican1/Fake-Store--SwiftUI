//
//  NetworkService.swift
//  Fake Store
//
//  Created by Abdurrahman Arıcan on 7.05.2025.
//

import Foundation
import Alamofire

class NetworkService {
    static let shared = NetworkService()
    
    private let baseURL = "https://api.escuelajs.co/api/v1/"
    
    private init(){
        
    }
    
    func request<T: Decodable, P: Encodable>(endPoint: String,
                               method: HTTPMethod = .get,
                               parameters: P? = nil,
                               headers: HTTPHeaders? = nil) async throws -> T {
        
        let url = baseURL + endPoint
       
          
            let dataRequest =  AF.request(url, method: method,parameters: parameters, encoder: JSONParameterEncoder.default, headers: headers)
            .validate(statusCode: 200..<299)
        
        let response  =  await dataRequest.serializingDecodable(T.self).response
       
        switch response.result {
        case .success(let data):
            return data
        case .failure(_):
            if let data = response.data {
                throw ErrorModel(title: "Network Error", message: String(data: data, encoding: .utf8) ?? "", statusCode:response.response?.statusCode)
                }
            throw ErrorModel(title: "Network Error", message: "Something Went Wrong",statusCode: response.response?.statusCode)
            }
        }
    
    func request<T: Decodable>(
            endPoint: String,
            method: HTTPMethod = .get,
            headers: HTTPHeaders? = nil
        ) async throws -> T {

            let url = baseURL + endPoint
            
            let dataRequest =  AF.request(url, method: method, headers: headers)
                .validate(statusCode: 200..<299)
         
            let response  =  await dataRequest.serializingDecodable(T.self).response
        
            switch response.result {
            case .success(let data):
                return data
            case .failure(_):
                 if let data = response.data {
                     throw ErrorModel(title: "Network Error", message: String(data: data, encoding: .utf8) ?? "Unknown error format", statusCode:response.response?.statusCode)
                 }

                 throw ErrorModel(title: "Network Error", message: "Something Went Wrong", statusCode: response.response?.statusCode)
            }
        }
    }
    
    
    


