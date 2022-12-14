//
//  SectionType.swift
//  eCommerceApp
//
//  Created by mehmet duran on 15.10.2022.
//

import Foundation
import UIKit

enum SectionType {
    case category
    case productSection
    case foodsSection
    
    var title:String? {
        switch self {
        case .category:
            return "Categories"
        case .productSection:
            return "Products"
        case .foodsSection:
            return "Foods"
        }
    }
}
