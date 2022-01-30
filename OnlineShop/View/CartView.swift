//
//  CartView.swift
//  OnlineShop
//
//  Created by Кирилл  Геллерт on 30.01.2022.
//

import UIKit

class CartView: UIView {
    
    let item: Item
    
    lazy var itemImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = item.name
        return label
    }()
    
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.text = item.name
        return label
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(item: Item) {
        self.item = item
        super.init(frame: CGRect.zero)
    }
    
}
