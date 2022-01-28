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
    
    init(name: String, imgName: String, items: [ItemGroup], possibleMemory: String, possibleColors: String) {
        self.name = name
        self.colors = possibleColors.convertToFormattedColorCollection()
        self.imgName = imgName
        self.items = items
        self.memorys = possibleMemory.convertToFormattedMemoryCollection()
    }
    
}

class Item: ItemGroup {
    
    let brand: String
    let price: Int
    let memory: String
    let ram: String
    let color: String
    let count: Int
    let itemGroup: ItemGroup

    init(brand: String,
         name: String,
         itemGroup: ItemGroup,
         color: String,
         price: String,
         memory: String,
         ram: String,
         count: String) {
        
        self.brand = brand
        self.itemGroup = itemGroup
        self.color = color
        self.price = Int(price) ?? 0
        self.memory = memory.getFormattedSize()
        self.ram = ram
        self.count = Int(count) ?? 0
        super.init(name: name, imgName: "\(name) \(color)", items: [ItemGroup](), possibleMemory: "", possibleColors: "")
    }
    
    func getFromStock(by color: String, and memory: String, and ram: String) -> Item? {
        if let items = itemGroup.items as? [Item] {
            return items.first(where: {
                $0.color == color &&
                $0.memory == memory &&
                $0.ram == ram
            })
        }
        return nil
    }

}



