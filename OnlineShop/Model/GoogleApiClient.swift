//
//  ApiClient.swift
//  OnlineShop
//
//  Created by Кирилл  Геллерт on 15.01.2022.
//

import GoogleAPIClientForREST

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
        guard let groupsListValues = finishedWithObject.valueRanges?.first?.values as? [[String]],
              let itemsListValues = finishedWithObject.valueRanges?.last?.values as? [[String]] else {
                  return
              }
        fillItems(groupsListValues: groupsListValues, itemsListValues: itemsListValues)
    }
    
    func fillItems(groupsListValues: [[String]], itemsListValues: [[String]]) {
        let groupKeys: [String] = groupsListValues.first ?? []
        let itemKeys: [String] = itemsListValues.first ?? []
        for rowGroups in groupsListValues {
            if rowGroups == groupsListValues.first {
                continue
            }
            let groupCurrentValues = rowGroups.convertToDictionary(keys: groupKeys)
            let currentGroup = ItemGroup(name: groupCurrentValues["Group name"] ?? "",
                                         imgName: groupCurrentValues["Image name"] ?? "",
                                         items: [ItemGroup](),
                                         memorys: groupCurrentValues["Memorys"] ?? "",
                                         colors: groupCurrentValues["Colors"] ?? "",
                                         rams: groupCurrentValues["Rams"] ?? "")
            itemList.append(currentGroup)
            if let itemGroup = itemList.first(where: {$0.name == groupCurrentValues["Parent"]}) {
                itemGroup.items.append(currentGroup)
                if groupCurrentValues["Is item"] == "TRUE" {
                    for rowItems in itemsListValues {
                        if rowItems == itemsListValues.first {
                            continue
                        }
                        if rowItems.contains(currentGroup.name) {
                            let itemCurrentValues = rowItems.convertToDictionary(keys: itemKeys)
                            currentGroup.items.append(Item(brand: itemCurrentValues["Company"] ?? "",
                                                           name: itemCurrentValues["Name"] ?? "",
                                                           itemGroup: currentGroup,
                                                           color: itemCurrentValues["Color"] ?? "",
                                                           price: itemCurrentValues["Price"] ?? "",
                                                           memory: itemCurrentValues["Memory"] ?? "",
                                                           ram: itemCurrentValues["Ram"] ?? "",
                                                           count: itemCurrentValues["Count"] ?? ""))
                        }
                    }
                }
            } else {
                itemTree.append(currentGroup)
            }
        }
    }
    
}
