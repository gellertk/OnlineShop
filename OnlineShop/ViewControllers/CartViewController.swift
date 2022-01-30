//
//  CartViewController.swift
//  OnlineShop
//
//  Created by Кирилл  Геллерт on 30.01.2022.
//

import UIKit

class CartViewController: UIViewController {

    var item: Item
    
    lazy var catalogView: UIView = {
        let view = CartView(item: item)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    init(item: Item) {
        self.item = item
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
