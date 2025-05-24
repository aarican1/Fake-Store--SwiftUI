//
//  BasketViewModel.swift
//  Fake Store
//
//  Created by Abdurrahman Arıcan on 22.05.2025.
//

import Foundation

final class BasketViewModel:ObservableObject {
    @Published var products: [Product] = []
    @Published var totalPrice : Double = 0.0
    
    static let shared = BasketViewModel()
    
    private init(){
        
    }
    
    
    func addProduct( product: Product)-> Bool{
        
        products.append(product)
        calculateTotalPrice()
        return true
    }
    
    func removeProduct(at index: Int){
        products.remove(at: index)
        calculateTotalPrice()
    }
    
    func calculateTotalPrice(){
        totalPrice = Double(products.reduce(0) { $0 + $1.price })
    }
    
}
