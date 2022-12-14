//
//  ProductsModel.swift
//  eCommerceAapp
//
//  Created by mehmet duran on 14.10.2022.
//

import Foundation
import SwiftyJSON

// MARK: - Products
struct Products: Codable {
    let status: String
    let statusCode: Int
    let result: [Result]
    let message: String
}

// MARK: - Result
struct Result: Codable {
    let id: Int
    let productName, type: String
    let oldPrice: Double
    let newPrice: Int
    let productImage: String
    let quantity: Int
    
    init(json:JSON) {
        self.id = json["id"].intValue
        self.productName = json["productName"].stringValue
        self.type = json["type"].stringValue
        self.oldPrice = json["oldPrice"].doubleValue
        self.newPrice = json["newPrice"].intValue
        self.productImage = json["productImage"].stringValue
        self.quantity = json["quantity"].intValue
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
