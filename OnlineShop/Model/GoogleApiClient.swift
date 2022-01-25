//
//  ApiClient.swift
//  OnlineShop
//
//  Created by Кирилл  Геллерт on 15.01.2022.
//

import GoogleAPIClientForREST
//import Foundation

var itemTree: [ItemGroup] = []

class GoogleApiClient: NSObject {
    
    var itemList: [ItemGroup] = []
    
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
        fillItems(groupValues: groupValues, itemValues: itemValues)
    }
    
    func fillItems(groupValues: [[String]], itemValues: [[String]]) {
        for rowIndex in groupValues.indices {
            if rowIndex == 0 {
                continue
            }
            let rowValues = groupValues[rowIndex]
            let currentGroup = ItemGroup(name: rowValues[1], imgName: rowValues[2], items: [ItemGroup](), possibleMemory: rowValues[4].convertInPossibleMemoryCollection(), possibleColors: rowValues[3].convertInPossibleColorCollection())
            itemList.append(currentGroup)
            let parent = rowValues[0]
            if let itemGroup = itemList.first(where: {$0.name == parent}) {
                itemGroup.items.append(currentGroup)
                if let memorys = itemGroup.memorys,
                   let colors = itemGroup.colors,
                       rowValues[6] == "TRUE" {
                    for memory in memorys {
                        for color in colors {
                            
                        }
                    }
                    for row in itemValues {
                        if row.contains(currentGroup.name) {
                            currentGroup.items.append(Item(companyName: row[0], name: row[1], itemGroup: currentGroup, color: row[2], price: Int(row[3]) ?? 0, memory: row[4].getFormattedSize(), ram: row[5], count: Int(row[6]) ?? 0))
                        }
                    }
                }
            } else {
                itemTree.append(currentGroup)
            }
        }
    }
}
