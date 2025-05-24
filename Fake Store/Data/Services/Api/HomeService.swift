//
//  HomeService.swift
//  Fake Store
//
//  Created by Abdurrahman Arıcan on 13.05.2025.
//

import Foundation

final class HomeService {
    static let shared = HomeService()
    private let  network = NetworkService.shared
    
    enum EndPoint: String {
        case products = "products/"
        case categories = "categories"
    }
    
    
    func getProducts() async throws -> Products {
        
        let response : Products  = try await network.request(endPoint: EndPoint.products.rawValue, method: .get, headers: nil)
        return response
    }
    
    func getCategories() async throws -> [Category] {
        
        let response : [Category]  = try await network.request(endPoint: EndPoint.categories.rawValue, method: .get, headers: nil)
        return response
    }
    
    func filterProductsByCategories(by categoryId: Int) async throws -> Products {
        let response : Products = try await network.request(endPoint: EndPoint.products.rawValue + "?categoryId=\(categoryId)", method: .get, headers: nil)
        
        return response
    }
    
    func filterProductsByTitle(by title:String) async throws -> Products {
        let response : Products  = try await network.request(endPoint:EndPoint.products.rawValue + "?title=\(title)" ,method: .get,
                                                             headers: nil)
        return response
    }
}


