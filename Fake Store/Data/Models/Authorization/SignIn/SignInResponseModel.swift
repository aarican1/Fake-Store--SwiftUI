//
//  SignInResponseModel.swift
//  Fake Store
//
//  Created by Abdurrahman Arıcan on 7.05.2025.
//

import Foundation


struct SignInResponseModel: Codable {
    let accessToken, refreshToken: String

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
    }
}
