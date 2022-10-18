//
//  CoreDataViewModel.swift
//  eCommerceAapp
//
//  Created by mehmet duran on 18.10.2022.
//

import Foundation

protocol CoreDataViewModelProtocol:AnyObject {
    func fetchCoreData(items:[BasketItems])
}

class CoreDataViewModel {
    
    let coreDataServices:CoreDataServices
    weak var CoreDataViewModelProtocol:CoreDataViewModelProtocol?
    
    init(coreDataServices:CoreDataServices) {
        self.coreDataServices = coreDataServices
    }
    
    public func fetchCoreData(){
        coreDataServices.getAllData { [weak self] items in
            self?.CoreDataViewModelProtocol?.fetchCoreData(items: items)
        }
    }
}
