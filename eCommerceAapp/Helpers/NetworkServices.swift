//
//  NetworkServices.swift
//  eCommerceAapp
//
//  Created by mehmet duran on 16.10.2022.
//

import Foundation
import Alamofire
import SwiftyJSON

enum Route {
    static let baseUrlFoods:String = "http://kasimadalan.pe.hu/yemekler/"
    static let baseUrlProducts:String = "http://159.223.0.153/"
    
    case fetchProdutcs
    case fetchFoods
    case fetchFoodImage(String)
    
    var description: String {
        switch self {
        case .fetchProdutcs: return "products"
        case .fetchFoods: return "tumYemekleriGetir.php"
        case .fetchFoodImage(let imageName): return "resimler/\(imageName)"
        }
    }
}

protocol NetworkServicesProtocol {
    func fetchFoods(completion : @escaping([Food]) -> ())
    func fetchProducts(completion: @escaping([Result]) -> ())
}

struct NetworkServices: NetworkServicesProtocol {
    
    func fetchFoods(completion : @escaping([Food]) -> ()) {
        
        let urlString = Route.baseUrlFoods + Route.fetchFoods.description
        let request = AF.request(urlString, method: .get)
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
        
        let urlString = Route.baseUrlProducts + Route.fetchProdutcs.description
        let request = AF.request(urlString, method: .get)
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
