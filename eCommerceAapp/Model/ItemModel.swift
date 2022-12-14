//
//  AllModel.swift
//  eCommerceAapp
//
//  Created by mehmet duran on 15.10.2022.
//

import Foundation

struct Item:Codable {
    
    let imageURL:String
    let title:String
    let price:String
    
    init(imageURL:String,title:String,price:String ) {
        self.imageURL = imageURL
        self.title = title
        self.price = price
    }
    
    init(food:Food) {
        self.imageURL = "http://kasimadalan.pe.hu/yemekler/resimler/\(food.yemek_resim_adi)"
        self.title = food.yemek_adi
        self.price = ("\(food.yemek_fiyat)")
    }
    
    init(product:Result) {
        self.imageURL = product.productImage
        self.title = product.productName
        self.price = "\(product.newPrice)"
    }
}
