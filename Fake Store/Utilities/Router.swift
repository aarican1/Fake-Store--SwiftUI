//
//  Router.swift
//  Fake Store
//
//  Created by Abdurrahman Arıcan on 10.05.2025.
//

import Foundation
import Observation
import SwiftUI

@Observable
class Router : ObservableObject {
    var navigationPath = NavigationPath()
    
    func navigate(to destination: Destination) {
        navigationPath.append(destination)
    }
    
    func navigateBack(){
        navigationPath.removeLast()
    }
    
    
    func navigateToRoot(){
        navigationPath.removeLast(navigationPath.count)
    }
    
    func setRoot(to destination: Destination) {
        navigationPath = NavigationPath()
        navigationPath.append(destination)
    }
    
    
    
    
    public enum Destination : Codable,Hashable {
        case signIn
        case signUp
        case mainTab
        case productDetail(product: Product)
    }
}
