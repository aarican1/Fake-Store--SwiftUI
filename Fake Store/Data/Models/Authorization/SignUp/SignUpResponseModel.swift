//
//  SignUpResponseModel.swift
//  Fake Store
//
//  Created by Abdurrahman Arıcan on 11.05.2025.
//

import Foundation

struct SignUpResponseModel : Codable {
    var id: Int
    var email, password, name, role: String
    var avatar: String
    var creationAt, updatedAt: String
}
