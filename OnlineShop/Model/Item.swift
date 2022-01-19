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
    var description: String?
    
    init(name: String, imgName: String, products: [ItemGroup]) {
        self.name = name
        self.imgName = imgName
        self.items = products
    }
        
}

class Item {
    
    var name: String
    var imgName: String {
        return name
    }
    var price: Int
    var memory: String
    var ram: String
    var color: String
    var count: Int

    init(name: String, price: Int, memory: String, ram: String, color: String, count: Int) {
        self.name = name
        self.price = price
        self.memory = memory
        self.ram = ram
        self.color = color
        self.count = count
        //super.init(name: name, imgName: imgName, products: [ItemGroup]())
    }

}

