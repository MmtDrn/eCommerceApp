//
//  NetworkViewModel.swift
//  eCommerceAapp
//
//  Created by mehmet duran on 16.10.2022.
//

import Foundation

protocol NetworkViewModelProtocol:AnyObject {
    func updateFoods(foods:[Food])
    func updateProducts(products:[Result])
}

class NetworkViewModel {
    
    private let NetworkServices:NetworkServices
    weak var NetworkViewModelProtocol:NetworkViewModelProtocol?
    
    init(services:NetworkServices) {
        self.NetworkServices = services
    }
    
    public func fectData(){
        
        self.NetworkServices.fetchFoods { [weak self] foods in
            self?.NetworkViewModelProtocol?.updateFoods(foods: foods)
        }
        self.NetworkServices.fetchProducts { [weak self] products in
            self?.NetworkViewModelProtocol?.updateProducts(products: products)
        }
    }
}
