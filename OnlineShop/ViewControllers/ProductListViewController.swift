//
//  ViewController.swift
//  OnlineShop
//
//  Created by Кирилл  Геллерт on 09.01.2022.
//

import UIKit

class ProductListViewController: UIViewController {
    
    lazy var productsView: UIView = {
        let v = ProductList.init(rootVC: self)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
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

