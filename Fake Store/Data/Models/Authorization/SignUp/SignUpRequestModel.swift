//
//  SignUpRequestModel.swift
//  Fake Store
//
//  Created by Abdurrahman Arıcan on 11.05.2025.
//

import Foundation

struct SignUpRequestModel: Codable {
    var name: String
    var email: String
    var password: String
    var avatar : String = "https://picsum.photos/800"
}
