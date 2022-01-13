//
//  Product.swift
//  OnlineShop
//
//  Created by Кирилл  Геллерт on 09.01.2022.
//

import Foundation
import GoogleAPIClientForREST

class ProductType {
    
    var name: String
    var imgName: String {
        return name
    }
    var products: [Product]
    
    init(name: String, imgName: String, products: [Product]) {
        self.name = name
        //self.imgName = imgName
        self.products = products
    }
        
}

class Product: ProductType {
    
    var price: Int
    var memorySize: String
    var color: String
    var description: String?
    
    override var imgName: String {
        return self.name
    }

    init(name: String, price: Int, description: String, imgName: String, memorySize: String, color: String, products: [Product], type: String) {
       
        self.price = price
        self.description = description
        self.memorySize = memorySize
        self.color = color
        super.init(name: name, imgName: imgName, products: products)
    }

}

extension Product {
    static func getProducts() -> [Product] {
        //return [Product.init(name: <#T##String#>, price: <#T##Int#>, description: <#T##String#>, imgName: <#T##String#>, memorySize: <#T##String#>, color: <#T##String#>, products: <#T##[Product]#>, type: <#T##String#>)]
     return [Product]()
    }
}

