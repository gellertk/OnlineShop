//
//  ApiClient.swift
//  OnlineShop
//
//  Created by Кирилл  Геллерт on 15.01.2022.
//

import GoogleAPIClientForREST

final class GoogleApiClient: GTLRSheetsService {
    
    static var items: [ItemGroup] = []
    
    private struct Constants {
        static let apiKey = "AIzaSyCKgh7usvAbBPAHT-PaIQPsIA2g9g8AEjI"
        static let spreadsheetId = "1DiuUKftlliXP-y6TS8qHruHyxlWesbcUhamzK6bG42s"
        public static let rangeItemGroups = "Groups"
        public static let rangeItems = "Items"
    }
    
    override init() {
        super.init()
        self.apiKey = Constants.apiKey
    }
    
    //completion: @escaping (Result<[ItemGroup], Error>) -> Void
    
    public func updateItemGroups() {
        
        let query = GTLRSheetsQuery_SpreadsheetsValuesGet.query(withSpreadsheetId: Constants.spreadsheetId,
                                                                range: Constants.rangeItemGroups)
        
        //let semaphore = DispatchSemaphore(value: 1)

        self.executeQuery(query) { [weak self] ticket, result, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let result = result as? GTLRSheets_ValueRange,
                  let groupsListValues = result.values as? [[String]],
                  let self = self else {
                      return
                  }
            self.fillItemGroups(groupsListValues: groupsListValues)
            //semaphore.signal()
        }
        //_ = semaphore.wait(wallTimeout: .distantFuture)
        //semaphore.wait(timeout: .distantFuture)
    }
    
    private func updateItems(itemGroup: ItemGroup) {
        
        let query = GTLRSheetsQuery_SpreadsheetsValuesGet.query(withSpreadsheetId: Constants.spreadsheetId,
                                                                range: Constants.rangeItems)

        self.executeQuery(query) { [weak self] ticket, result, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let result = result as? GTLRSheets_ValueRange,
                  let items = result.values as? [[String]],
                  let self = self else {
                      return
            }
            self.fill(group: itemGroup, with: items)
        }
    }

    private func fillItemGroups(groupsListValues: [[String]]) {
        
        var itemList: [ItemGroup] = []
        let groupKeys: [String] = groupsListValues.first ?? []
        
        for rowGroups in groupsListValues {
            if rowGroups == groupsListValues.first {
                continue
            }
            let currentRowValues = rowGroups.convertToDictionary(keys: groupKeys)
            let currentGroup = ItemGroup(name: currentRowValues["Group name"] ?? "",
                                         imgName: currentRowValues["Image name"] ?? "",
                                         items: [ItemGroup](),
                                         memorys: currentRowValues["Memorys"] ?? "",
                                         colors: currentRowValues["Colors"] ?? "",
                                         rams: currentRowValues["Rams"] ?? "")
            itemList.append(currentGroup)
            if let itemGroup = itemList.first(where: {$0.name == currentRowValues["Parent"]}) {
                itemGroup.items.append(currentGroup)
            } else {
                GoogleApiClient.items.append(currentGroup)
            }
        }
    }
    
    private func fill(group itemGroup: ItemGroup, with itemsListValues: [[String]]) {
        
        let itemKeys: [String] = itemsListValues.first ?? []
        
        for rowItems in itemsListValues {
            if rowItems == itemsListValues.first {
                continue
            }
            if rowItems.contains(itemGroup.name) {
                let itemCurrentValues = rowItems.convertToDictionary(keys: itemKeys)
                itemGroup.items.append(Item(brand: itemCurrentValues["Company"] ?? "",
                                               name: itemCurrentValues["Name"] ?? "",
                                               itemGroup: itemGroup,
                                               color: itemCurrentValues["Color"] ?? "",
                                               price: itemCurrentValues["Price"] ?? "",
                                               memory: itemCurrentValues["Memory"] ?? "",
                                               ram: itemCurrentValues["Ram"] ?? "",
                                               count: itemCurrentValues["Count"] ?? ""))
            }
        }
    }
    
}
