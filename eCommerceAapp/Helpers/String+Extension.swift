//
//  String+Extension.swift
//  eCommerceAapp
//
//  Created by mehmet duran on 20.10.2022.
//

import Foundation

extension String {
    var asUrl:URL? {
        return URL(string: self)
    }
}
