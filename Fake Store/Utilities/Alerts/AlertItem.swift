//
//  AlertItem.swift
//  Fake Store
//
//  Created by Abdurrahman Arıcan on 10.05.2025.
//

import SwiftUI

struct AlertItem: Identifiable {
    var id: UUID = UUID()
    var title: Text
    var message: Text
    var dismissButton: Alert.Button
    
    static func createAlert(title:String, message:String)->AlertItem{
        return AlertItem(title: Text(title), message: Text(message), dismissButton: .default(Text("OK")))
    }
}

