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
    
    func request<T: Decodable>(endPoint: String,
    method: HTTPMethod = .get,
    parameters: Parameters? = nil,
    headers: HTTPHeaders? = nil
    completion: @escaping(Result<T,AFError>)->Void) {
    
        let url = baseURL + endPoint
        
        AF.request(url, method: method,parameters: parameters,headers: headers, encoding: JSONEncoding.default)
        
            .validate()
            .responseDecodable(of: T.self) { response in
                completion(response.result)
            }
    }
}
