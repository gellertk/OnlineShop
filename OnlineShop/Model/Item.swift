//
//  Product.swift
//  OnlineShop
//
//  Created by Кирилл  Геллерт on 09.01.2022.
//

import Foundation

class ItemGroup {
    
    var name: String
    var colors: [String]?
    var imgName: String
    var memorys: [Int]?
    var items: [ItemGroup]
    
    init(name: String, imgName: String, products: [ItemGroup]) {
        self.name = name
        self.imgName = imgName
        self.items = products
    }
        
}

class Item: ItemGroup {
    
    var price: Int
    var memory: String
    var color: String
    var description: String?
    var count: Int

    init(type: ItemGroup?, name: String, imgName: String, price: Int, description: String, memory: String, color: String, count: Int) {
        self.price = price
        self.description = description
        self.memory = memory
        self.color = color
        self.count = count
        super.init(name: name, imgName: imgName, products: [ItemGroup]())
    }

}

