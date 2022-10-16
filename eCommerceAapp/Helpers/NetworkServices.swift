//
//  NetworkServices.swift
//  eCommerceAapp
//
//  Created by mehmet duran on 16.10.2022.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol NetworkServicesProtocol {
    func fetchFoods(completion : @escaping([Food]) -> ())
    func fetchProducts(completion: @escaping([Result]) -> ())
}

class NetworkServices: NetworkServicesProtocol {
    
    func fetchFoods(completion : @escaping([Food]) -> ()) {
        
        let request = AF.request("http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php", method: .get)
        var foods = [Food]()
        
        request.response { response in
            
            guard let data = response.data else { return }
            do {
                let json = try JSON(data: data)
                let foodsJson = json["yemekler"].arrayValue
                for json in foodsJson {
                    let food = Food(json: json)
                    foods.append(food)
                }
                completion(foods)
            }catch{
                print("-------" + error.localizedDescription + "-------")
            }
        }
    }
    
    func fetchProducts(completion: @escaping([Result]) -> ()) {
        
        let request = AF.request("http://159.223.0.153/products", method: .get)
        var products = [Result]()
        
        request.response { response in
            
            guard let data = response.data else { return }
            do{
                let jsonData = try JSON(data: data)
                let jsons = jsonData["result"].arrayValue
                for json in jsons {
                    let product = Result(json: json)
                    products.append(product)
                }
                completion(products)
            }catch{
                print("-------" + error.localizedDescription + "-------")
            }
        }
    }
}
