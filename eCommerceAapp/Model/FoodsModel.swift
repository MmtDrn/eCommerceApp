//
//  FoodsModel.swift
//  eCommerceAapp
//
//  Created by mehmet duran on 14.10.2022.
//

import Foundation

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
}
