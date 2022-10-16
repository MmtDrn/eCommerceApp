//
//  FoodsModel.swift
//  eCommerceAapp
//
//  Created by mehmet duran on 14.10.2022.
//

import Foundation
import SwiftyJSON

// MARK: - Foods
struct Foods:Codable {
    let yemekler:[Food]
}

// MARK: - Food
struct Food:Codable {
    let yemek_id:String
    let yemek_adi:String
    let yemek_resim_adi:String
    let yemek_fiyat:String
    
    init(json:JSON) {
        self.yemek_adi = json["yemek_adi"].stringValue
        self.yemek_id = json["yemek_id"].stringValue
        self.yemek_resim_adi = json["yemek_resim_adi"].stringValue
        self.yemek_fiyat = json["yemek_fiyat"].stringValue
    }
}
