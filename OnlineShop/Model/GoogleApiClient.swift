//
//  ApiClient.swift
//  OnlineShop
//
//  Created by Кирилл  Геллерт on 15.01.2022.
//

import GoogleAPIClientForREST

var itemTree = [ItemGroup]()

class GoogleApiClient: NSObject {
    
    var itemList = [ItemGroup]()
    
    func getItems() {
        let service = GTLRSheetsService()
        let spreadsheetId = "1DiuUKftlliXP-y6TS8qHruHyxlWesbcUhamzK6bG42s"
        service.apiKey = "AIzaSyCKgh7usvAbBPAHT-PaIQPsIA2g9g8AEjI"
        let query = GTLRSheetsQuery_SpreadsheetsValuesBatchGet.query(withSpreadsheetId: spreadsheetId)
        query.ranges = ["Groups", "Items"]
        service.executeQuery(query, delegate: self, didFinish: #selector(displayResultWithTicket(ticket:finishedWithObject:error:)))
    }
    
    @objc func displayResultWithTicket(ticket: GTLRServiceTicket, finishedWithObject: GTLRSheets_BatchGetValuesResponse, error: NSError?) {
        if let error = error {
            print(error.localizedDescription)
            return
        }
        guard let groupValues = finishedWithObject.valueRanges?.first?.values as? [[String]],
              let itemValues = finishedWithObject.valueRanges?.last?.values as? [[String]] else { return }
        var firstRowIndex = 1
        fillItems(currentType: nil, groupValues: groupValues, itemValues: itemValues, rowIndex: &firstRowIndex)
    }
    
    func fillItems(currentType: ItemGroup?, groupValues: [[String]], itemValues: [[String]], rowIndex: inout Int) {
        while rowIndex < groupValues.indices.count {
            let parent = groupValues[rowIndex][0]
            let currentGroup = ItemGroup.init(name: groupValues[rowIndex][1], imgName: groupValues[rowIndex][2], products: [ItemGroup]())
            itemList.append(currentGroup)
            if let parentType = itemList.first(where: {$0.name == parent}) {
                parentType.items.append(currentGroup)
                if groupValues[rowIndex][6] == "TRUE" {
                    itemValues.forEach { row in
                        if row.contains(currentGroup.name) {
//                            currentGroup.items.append(Item.init(name: row[0], price: row[2], memory: row, ram: <#T##String#>, color: <#T##String#>, count: <#T##Int#>))
                        }
                    }
                }
                
            } else {
                itemTree.append(currentGroup)
            }
            rowIndex += 1
        }
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


