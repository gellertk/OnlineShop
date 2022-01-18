//
//  ApiClient.swift
//  OnlineShop
//
//  Created by Кирилл  Геллерт on 15.01.2022.
//

import Foundation
import GoogleAPIClientForREST

var itemTree = [ItemGroup]()

class GoogleApiClient: NSObject {
    
    var itemList = [ItemGroup]()
    
    func getItems() {
        let service = GTLRSheetsService()
        let spreadsheetId = "1DiuUKftlliXP-y6TS8qHruHyxlWesbcUhamzK6bG42s"
        service.apiKey = "AIzaSyCKgh7usvAbBPAHT-PaIQPsIA2g9g8AEjI"
        let query = GTLRSheetsQuery_SpreadsheetsValuesBatchGet.query(withSpreadsheetId: spreadsheetId)
        query.ranges = ["ProductTypes", "Products"]
        service.executeQuery(query, delegate: self, didFinish: #selector(displayResultWithTicket(ticket:finishedWithObject:error:)))
    }
    
    @objc func displayResultWithTicket(ticket: GTLRServiceTicket, finishedWithObject: GTLRSheets_BatchGetValuesResponse, error: NSError?) {
        if let error = error {
            print(error.localizedDescription)
            return
        }
        guard let productTypesValues = finishedWithObject.valueRanges?.first?.values as? [[String]],
              let productsValue = finishedWithObject.valueRanges?.last?.values as? [[String]] else { return }
        var firstRowIndex = 1
        fillProductType(currentType: nil,values: productTypesValues, rowIndex: &firstRowIndex)
    }
    
    func fillProductType(currentType: ItemGroup?, values: [[String]], rowIndex: inout Int) {
        while rowIndex < values.indices.count {
            let parent = values[rowIndex][0]
            let currentType = ItemGroup.init(name: values[rowIndex][1], imgName: values[rowIndex][2], products: [ItemGroup]())
            itemList.append(currentType)
            if let parentType = itemList.first(where: {$0.name == parent}) {
                parentType.items.append(currentType)
            } else {
                itemTree.append(currentType)
            }
            rowIndex += 1
            //fillProductType(currentType: currentType, values: values, rowIndex: &rowIndex)
        }
        
        var asd = 1
    }
    
//    func fillProductType(currentType: ProductType?, values: [[String]], rowIndex: inout Int) {
//        while rowIndex < values.indices.count {
//            let parent = values[rowIndex][0]
//            let currentType = ProductType.init(name: values[rowIndex][1], imgName: values[rowIndex][2], products: [ProductType]())
//            productList.append(currentType)
//            if let parentType = productList.first(where: {$0.name == parent}) {
//                parentType.products.append(currentType)
//            } else {
//                productTypes.append(currentType)
//            }
//            rowIndex += 1
//            fillProductType(currentType: currentType, values: values, rowIndex: &rowIndex)
//        }
//    }
    
}


