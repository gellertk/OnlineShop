//
//  MenuViewController.swift
//  OnlineShop
//
//  Created by Кирилл  Геллерт on 18.01.2022.
//

import UIKit

class MenuViewController: UIViewController {

    lazy var productsView: UIView = {
        let v = Menu.init(rootVC: self)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GoogleApiClient().getItems()
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
