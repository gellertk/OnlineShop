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
    
    init() {
        super.init(frame: CGRect.zero)
        backgroundColor = .green
        
        //let asd = getProducts()
        let asd = GoogleApiClient().getProducts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
}
