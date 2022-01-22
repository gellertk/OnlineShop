//
//  MenuViewController.swift
//  OnlineShop
//
//  Created by Кирилл  Геллерт on 18.01.2022.
//

import UIKit

class MenuViewController: UIViewController {

    lazy var menuView: UIView = {
        let view = MenuView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GoogleApiClient().getItems()
        setupView()
    }
    
    func setupView() {
        view.addSubview(menuView)
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            menuView.topAnchor.constraint(equalTo: view.topAnchor),
            menuView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            menuView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            menuView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }

}
