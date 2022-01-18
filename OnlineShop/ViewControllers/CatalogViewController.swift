//
//  ViewController.swift
//  OnlineShop
//
//  Created by Кирилл  Геллерт on 09.01.2022.
//

import UIKit

class CatalogViewController: UIViewController {
    
    let items: [ItemGroup]
    
    lazy var productsView: UIView = {
        let v = Catalog.init(rootVC: self, items: items)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    init(items: [ItemGroup]) {
        self.items = items
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
        view.addSubview(productsView)
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            productsView.topAnchor.constraint(equalTo: view.topAnchor),
            productsView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            productsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            productsView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }

}

