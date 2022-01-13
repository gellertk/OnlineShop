//
//  ProductList.swift
//  OnlineShop
//
//  Created by Кирилл  Геллерт on 09.01.2022.
//

import UIKit
import GoogleAPIClientForREST

class ProductList: UIView {
    
//    lazy var sgmntProductType: UISegmentedControl = {
//       let sgmnt = UISegmentedControl(items: [""])
//       return sgmnt
//    }()
    let service = GTLRSheetsService()
    
    init() {
        super.init(frame: CGRect.zero)
        backgroundColor = .green
        getData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getData() {
        
        //var asd = GTLRSheets_Spreadsheet
        service.apiKey = "AIzaSyCKgh7usvAbBPAHT-PaIQPsIA2g9g8AEjI"
        let spreadsheetId = "1DiuUKftlliXP-y6TS8qHruHyxlWesbcUhamzK6bG42s"
        
        let query1 = GTLRSheetsQuery_SpreadsheetsGet.query(withSpreadsheetId: spreadsheetId)
        service.executeQuery(query1) { (ticket, data, error) in
             print("GTLRService ticket: \(ticket)")
             if error != nil {
                 print("GTLRService potential show query error: \(error!)")
             }
             else {
                 print("data: \(data ?? "unknown data")")
             }
            if let data = data as? GTLRSheets_Spreadsheet {
                if let sheets = data.sheets {
                    sheets[0].properties?.title
                }
            }
         }
        
        let query = GTLRSheetsQuery_SpreadsheetsValuesGet.query(withSpreadsheetId: spreadsheetId, range: "iPhone")
        service.executeQuery(query, delegate: self, didFinish: #selector(displayResultWithTicket(ticket:finishedWithObject:error:)))
    }
    
    @objc func displayResultWithTicket(ticket: GTLRServiceTicket,
                                       finishedWithObject result : GTLRSheets_ValueRange,
                                       error : NSError?) {
        print("Started callback")
        if let error = error {
            print("\(error.localizedDescription)")
            return
        }
       
        // turn 2d array into string
        let rows = result.values!
        for row in rows {
            for _ in row {
                // update global variable
                //print(item as? String)
            }
        }
        print("Finished callback")
    }
    
}
