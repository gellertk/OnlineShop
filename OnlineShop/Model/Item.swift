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
    var memorys: [String]?
    var rams: [String]?
    var description: String?
    var items: [ItemGroup]
    
    init(name: String, imgName: String, items: [ItemGroup], possibleMemory: [String], possibleColors: [String]) {
        self.name = name
        self.imgName = imgName
        self.items = items
        self.memorys = possibleMemory
        self.colors = possibleColors
    }
    
}

class Item: ItemGroup {
    
    var companyName: String
    var price: Int
    var memory: String
    var ram: String
    var color: String
    var count: Int
    var itemGroup: ItemGroup

    init(companyName: String, name: String, itemGroup: ItemGroup, color: String, price: Int, memory: String, ram: String, count: Int) {
        self.companyName = companyName
        self.itemGroup = itemGroup
        self.color = color
        self.price = price
        self.memory = memory
        self.ram = ram
        self.count = count
        super.init(name: name, imgName: "\(name) \(color)", items: [ItemGroup](), possibleMemory: [String](), possibleColors: [String]())
    }

}

func getFromStock(itemGroup: ItemGroup, color: String, memory: String) -> Item? {
    if let chosenColor = itemGroup.colors?.first(where: { $0 == color }),
       let items = itemGroup.items as? [Item],
       let chosenItem = items.first(where: { $0.color == chosenColor && $0.memory == memory && $0.count > 0 }) {
        return chosenItem
    }
    return nil
}

