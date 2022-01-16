//
//  Product.swift
//  OnlineShop
//
//  Created by Кирилл  Геллерт on 09.01.2022.
//

import Foundation


class ProductType {
    
    var name: String
    var colors: [String]?
    var imgName: String
    var memorys: [Int]?
    var products: [ProductType]
    
    init(name: String, imgName: String, products: [ProductType]) {
        self.name = name
        self.imgName = imgName
        self.products = products
    }
        
}

class Product: ProductType {
    
    var price: Int
    var memory: String
    var color: String
    var description: String?

    init(type: ProductType?, name: String, imgName: String, price: Int, description: String, memory: String, color: String) {
        self.price = price
        self.description = description
        self.memory = memory
        self.color = color
        super.init(name: name, imgName: imgName, products: [ProductType]())
    }

}

