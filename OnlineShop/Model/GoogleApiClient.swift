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
            let parent = rowValues[0]
            let currentGroup = ItemGroup(name: rowValues[1], imgName: rowValues[2], items: [ItemGroup](), possibleMemory: rowValues[4].getPossibleMemoryCollection(), possibleColors: rowValues[3].getPossibleColorCollection())
            itemList.append(currentGroup)
            if let parentGroupName = itemList.first(where: {$0.name == parent}) {
                parentGroupName.items.append(currentGroup)
                if rowValues[6] == "TRUE" {
                    itemValues.forEach { row in
                        if row.contains(currentGroup.name) {
                            currentGroup.items.append(Item(name: row[0], price: Int(row[2]) ?? 0, memory: row[3], ram: row[4], color: row[1], count: Int(row[5]) ?? 0))
                        }
                    }
                }
            } else {
                itemTree.append(currentGroup)
            }
        }
    }
}
