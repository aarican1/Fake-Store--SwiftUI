//
//  Product.swift
//  Fake Store
//
//  Created by Abdurrahman Arıcan on 12.05.2025.
//

import Foundation

// MARK: - Product
struct Product: Codable,Hashable,Identifiable {
    let id: Int
    let title, slug: String
    let price: Int
    let description: String
    let category: Category
    let images: [String]
    let creationAt, updatedAt: String
}

// MARK: - Category
struct Category: Codable,Hashable {
    let id: Int
    let name, slug: String
    let image: String
    let creationAt, updatedAt: String
}



typealias Products = [Product]


let mockCategory = Category(id: 1, name: "Test Category", slug: "Test", image: "Test", creationAt: "test", updatedAt: "test")

let mockProduct = Product(
        id: 1,
        title: "Test Product",
        slug: "Test",
        price: 100,
        description: "Test",
        category: mockCategory,
        images: ["https://picsum.photos/200/300","https://picsum.photos/200/300"],
        creationAt: "test", updatedAt: "test"
)
