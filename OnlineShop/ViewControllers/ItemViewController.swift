//
//  ItemViewController.swift
//  OnlineShop
//
//  Created by Кирилл  Геллерт on 22.01.2022.
//

import UIKit

class ItemViewController: UIViewController {

    let items: ItemGroup
    let currentItem: Item
    
    lazy var itemView: UIView = {
        let view = ItemView.init(itemGroup: items, currentItem: currentItem)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    init(items: ItemGroup, currentItem: Item) {
        self.items = items
        self.currentItem = currentItem
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        view.addSubview(itemView)
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            itemView.topAnchor.constraint(equalTo: view.topAnchor),
            itemView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            itemView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            itemView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}
