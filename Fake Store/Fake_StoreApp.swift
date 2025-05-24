//
//  Fake_StoreApp.swift
//  Fake Store
//
//  Created by Abdurrahman Arıcan on 6.05.2025.
//

import SwiftUI

@main
struct Fake_StoreApp: App {
    @State private var router  = Router()
    var body: some Scene {
        WindowGroup {
            SplashView()
                .environment(router)
        }
    }
}
