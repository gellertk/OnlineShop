//
//  Menu.swift
//  OnlineShop
//
//  Created by Кирилл  Геллерт on 18.01.2022.
//

import UIKit

class MenuView: UIView {
    
    var items: [ItemGroup]?
    
    lazy var catalogButton: UIButton = {
        var button = UIButton()
        button.setTitle("Каталог", for: .normal)
        button.addTarget(self, action: #selector(didTapCatalogButton(sender:)), for: .touchUpInside)
        button.layer.cornerRadius = 1
        return button
    }()
    
    @objc func didTapCatalogButton(sender: UIButton) {
        guard itemTree.count > 0 else {
            return
        }
        let catalogViewController = CatalogViewController(items: itemTree)
        if let navigationController = window?.rootViewController as? UINavigationController {
            navigationController.pushViewController(catalogViewController, animated: true)
        }
    }
    
    init() {
        super.init(frame: CGRect.zero)
        backgroundColor = .lightGray
        setupView()
    }
    
    func setupView() {
        [catalogButton].forEach { newView in
            newView.translatesAutoresizingMaskIntoConstraints = false
            addSubview(newView)
        }
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            catalogButton.widthAnchor.constraint(equalToConstant: 100),
            catalogButton.heightAnchor.constraint(equalToConstant: 44),
            catalogButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            catalogButton.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
