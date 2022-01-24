//
//  Product.swift
//  OnlineShop
//
//  Created by Кирилл  Геллерт on 09.01.2022.
//

import Foundation

class ItemGroup {
    
    let name: String
    let colors: [String]?
    let imgName: String
    let memorys: [String]?
    var rams: [String]?
    //let description: String?
    var items: [ItemGroup]
    
    init(name: String, imgName: String, items: [ItemGroup], possibleMemory: [String], possibleColors: [String]) {
        self.name = name
        self.colors = possibleColors
        self.imgName = imgName
        self.items = items
        self.memorys = possibleMemory
    }
    
}

class Item: ItemGroup {
    
    let companyName: String
    let price: Int
    let memory: String
    let ram: String
    let color: String
    let count: Int
    let itemGroup: ItemGroup

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

