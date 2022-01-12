//
//  Product.swift
//  OnlineShop
//
//  Created by Кирилл  Геллерт on 09.01.2022.
//

import Foundation
import GoogleAPIClientForREST

struct Product {
    var name: String
    var price: Int?
    var description: String?
    var imgName: String?
    var memorySize: String?
    var color: String?
    var products: [Product]?
    
    init(name: String, imgName: String, products: [Product]) {
        self.name = name
        self.imgName = imgName
        self.products = products
    }
    
    init(name: String, price: Int, description: String, imgName: String, memorySize: String, color: String) {
        self.name = name
        self.price = price
        self.description = description
        self.imgName = imgName
        self.memorySize = memorySize
        self.color = color
    }

}

extension Product {
    static func getProducts() -> [Product] {
    
     return [Product]()
    }
}

