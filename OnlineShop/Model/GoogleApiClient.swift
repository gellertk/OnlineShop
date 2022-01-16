//
//  ApiClient.swift
//  OnlineShop
//
//  Created by Кирилл  Геллерт on 15.01.2022.
//

import Foundation
import GoogleAPIClientForREST

class GoogleApiClient: NSObject {
    
    var productList = [ProductType]()
    var productTypes = [ProductType]()
    
    func getProducts() -> [ProductType] {
        
        let service = GTLRSheetsService()
        service.apiKey = "AIzaSyCKgh7usvAbBPAHT-PaIQPsIA2g9g8AEjI"
        let spreadsheetId = "1DiuUKftlliXP-y6TS8qHruHyxlWesbcUhamzK6bG42s"
        
        let query = GTLRSheetsQuery_SpreadsheetsValuesBatchGet.query(withSpreadsheetId: spreadsheetId)
        query.ranges = ["ProductTypes", "Products"]
        service.executeQuery(query, delegate: self, didFinish: #selector(displayResultWithTicket(ticket:finishedWithObject:error:)))
        
        return [ProductType]()
    }
    
    func fillProductType(currentType: ProductType? , values: [[String]], startIndex: Int) {
        var index = startIndex
        for rowIndex in index...values.indices.count {
            let parent = values[rowIndex][0]
            let currentType = ProductType.init(name: values[rowIndex][1], imgName: values[rowIndex][2], products: [ProductType]())
            productList.append(currentType)
            if let parentType = productList.first {$0.name == parent} {
                parentType.products.append(currentType)
            } else {
                productTypes.append(currentType)
            }
            index += 1
            if index == values.indices.count {
                return
            }
            fillProductType(currentType: currentType, values: values, startIndex: index)
        }
    }
    
    @objc func displayResultWithTicket(ticket: GTLRServiceTicket, finishedWithObject: GTLRSheets_BatchGetValuesResponse, error: NSError?) {
        if let error = error {
            print(error.localizedDescription)
            return
        }
        guard let productTypesValues = finishedWithObject.valueRanges?.first?.values as? [[String]],
              let productsValue = finishedWithObject.valueRanges?.last?.values as? [[String]] else {
                  return
              }
        fillProductType(currentType: nil,values: productTypesValues, startIndex: 1)
    }
    
}


