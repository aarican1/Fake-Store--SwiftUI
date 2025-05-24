//
//  ErrorModel.swift
//  Fake Store
//
//  Created by Abdurrahman Arıcan on 10.05.2025.
//


struct ErrorModel : Error{
    let title: String
    let message: String
    var statusCode: Int?
}
