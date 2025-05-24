//
//  KeychainService.swift
//  Fake Store
//
//  Created by Abdurrahman Arıcan on 7.05.2025.
//

import Foundation

enum KeychainError: Error {
    case stringToDataConversionFailed
    case itemAddFailed(OSStatus)
    case itemCopyMatchingFailed(OSStatus)
    case dataToStringConversionFailed
    case unexpectedItemData
    case itemDeleteFailed(OSStatus)
}

class KeychainService {
    static let shared = KeychainService()
    
    private init() {}
    
    
    func save( for key:String, _ value: String) throws {
        guard let data = value.data(using: .utf8) else { return}
        
        let query: [String:Any] = [
            kSecClass       : kSecClassGenericPassword,
            kSecAttrAccount : key,
            kSecValueData   : data
        ] as [String : Any]
        
        SecItemDelete(query as CFDictionary)
        
        let status  = SecItemAdd(query as CFDictionary, nil)
        
        if status != errSecSuccess {
            throw KeychainError.itemAddFailed(status)
        }
    }
    
    func read (for key: String) throws -> String? {
        
        let query: [String:Any] = [
            kSecClass       : kSecClassGenericPassword,
            kSecAttrAccount : key,
            kSecReturnData  : true,
            kSecMatchLimit  : kSecMatchLimitOne
        ] as [String: Any]
        
        var dataTypeRef : AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary,  &dataTypeRef)
        
        if status == noErr {
            if let data = dataTypeRef as? Data,
               let result = String(data: data, encoding: .utf8) {
                return result
            }
        }
        throw KeychainError.dataToStringConversionFailed
    }
    

    func delete(for key: String) throws {
        let query : [String:Any] = [
            kSecClass : kSecClassGenericPassword,
            kSecAttrAccount : key
        ] as [String : Any ]
        
        let status  =  SecItemDelete(query as CFDictionary)
        
        if !(status == noErr) {
            throw KeychainError.itemDeleteFailed(status)
        }
        
    }
    
    enum AuthKey:String{
        case accessToken = "accessToken"
        case refreshToken = "refreshToken"
    }
    
}
