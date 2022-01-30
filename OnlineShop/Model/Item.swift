//
//  Product.swift
//  OnlineShop
//
//  Created by Кирилл  Геллерт on 09.01.2022.
//

import Foundation

class ItemGroup {
    
    let name: String
    let imgName: String
    let memorys: [String]
    let colors: [String]
    var rams: [String]
    var items: [ItemGroup]
    
    init(name: String,
         imgName: String,
         items: [ItemGroup],
         memorys: String = "",
         colors: String = "",
         rams: String = "") {
        
        self.name = name
        self.colors = colors.toArray()
        self.imgName = imgName
        self.items = items
        self.memorys = memorys.toArray()
        self.rams = rams.toArray()
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
        self.memory = memory
        self.ram = ram
        self.count = Int(count) ?? 0
        super.init(name: name, imgName: "\(name) \(color)", items: [ItemGroup]())
    }
    
    func getFromStock(by color: String, and memory: String, and ram: String) -> Item? {
        if let items = self.itemGroup.items as? [Item] {
            return items.first(where: {
                $0.color == color &&
                $0.memory == memory &&
                $0.ram == ram
            })
        }
        return nil
    }

}



