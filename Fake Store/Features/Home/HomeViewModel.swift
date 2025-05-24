//
//  HomeViewModel.swift
//  Fake Store
//
//  Created by Abdurrahman Arıcan on 12.05.2025.
//

import Foundation

final class HomeViewModel : ObservableObject {
    @Published var searchText: String = ""
    @Published var isLoading: Bool = false
    @Published var products: [Product] = []
    @Published var shownProducts : [Product] = []
    @Published var categories: [Category] = []
    @Published var selectedCategory: Category?
    @Published var alertItem: AlertItem?
    
    private let service =  HomeService.shared
    
    @MainActor
    func getProducts() async {
        do {
            isLoading = true
            let products = try await service.getProducts()
            self.products = products
            self.shownProducts = products
            isLoading = false
        }
        catch let error as ErrorModel {
            alertItem = AlertItem.createAlert(title:error.title , message:error.message)
            isLoading = false
        }
        catch {
            alertItem = AlertItem.createAlert(title:"Error" , message: "Something went wrong. Please try again later.")
            isLoading  = false
        }
    }
    
    
    @MainActor
    func getCategories () async {
        do {
            isLoading = true
            categories = try await service.getCategories()
            isLoading = false
        }
        catch let error as  ErrorModel {
            alertItem = AlertItem.createAlert(title: error.title, message: error.message)
            isLoading = false
        }
        catch{
            alertItem = AlertItem.createAlert(title:"Error" , message: "Something went wrong. Please try again later.")
            isLoading = false
        }
        
    }
    
    
    @MainActor
    func filterProductsByCategory(by category :Category) async{
        do {
            selectedCategory = category
            isLoading = true
            shownProducts = try await service.filterProductsByCategories(by: category.id)
            isLoading = false
        }
        catch let error as  ErrorModel {
            alertItem = AlertItem.createAlert(title: error.title, message: error.message)
            isLoading = false
        }
        catch{
            alertItem = AlertItem.createAlert(title:"Error" , message: "Something went wrong. Please try again later.")
            isLoading = false
        }
    }
    
    
    @MainActor
    func filterProductsByTitle() async{
        do {
            isLoading = true
            shownProducts = try await service.filterProductsByTitle(by: searchText)
            isLoading = false
        }
        catch let error as  ErrorModel {
            alertItem = AlertItem.createAlert(title: error.title, message: error.message)
            isLoading = false
        }
        catch{
            alertItem = AlertItem.createAlert(title:"Error" , message: "Something went wrong. Please try again later.")
            isLoading = false
        }
    }
    
    
    
    
}
