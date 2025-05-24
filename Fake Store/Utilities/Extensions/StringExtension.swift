//
//  StringExtension.swift
//  Fake Store
//
//  Created by Abdurrahman Arıcan on 7.05.2025.
//

import Foundation

extension String {
    
    
    var isValidEmail: Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicte =  NSPredicate(format: "SELF MATCHES %@", emailFormat)
        return emailPredicte.evaluate(with: self)
    }
}
