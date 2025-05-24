//
//  ProfileResponseModel.swift
//  Fake Store
//
//  Created by Abdurrahman Arıcan on 21.05.2025.
//

import Foundation

struct ProfileResponseModel: Codable {
    var id: Int
    var email,password,name,role : String
    var avatar : String
}

let mockProfile : ProfileResponseModel = ProfileResponseModel(id: 1, email: "a@po.com", password: "test12.", name: "Abdurrahman Arıcan", role: "customer", avatar: "https://i.imgur.com/LDOO4Qs.jpg")
