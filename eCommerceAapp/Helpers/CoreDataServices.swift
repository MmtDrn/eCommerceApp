//
//  CoreDataServices.swift
//  eCommerceAapp
//
//  Created by mehmet duran on 17.10.2022.
//

import UIKit
import CoreData

protocol CoreDataServiceProtocol{
    func getAllData(completion: @escaping ([BasketItems]) -> ())
}

class CoreDataServices: CoreDataServiceProtocol {
    
    static let shared = CoreDataServices()
    private let context = appDelegate.persistentContainer.viewContext
    
    func getAllData(completion: @escaping ([BasketItems]) -> ()) {
        
        DispatchQueue.main.async {
            do {
                let items = try? self.context.fetch(BasketItems.fetchRequest())
                
                if let items = items {
                    completion(items)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func addItem(item:Item){
        
        let basketItem = BasketItems(context: self.context)
        
        basketItem.imageURL = item.imageURL
        basketItem.title = item.title
        basketItem.price = item.price
        basketItem.count = 1
        
        appDelegate.saveContext()
    }
    
    func deleteAllItem(items:[BasketItems]){
        
        for item in items {
            context.delete(item)
        }
        appDelegate.saveContext()
    }
}
