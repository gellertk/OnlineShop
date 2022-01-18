//
//  Menu.swift
//  OnlineShop
//
//  Created by Кирилл  Геллерт on 18.01.2022.
//

import UIKit

class Menu: UIView {
    
    var items: [ItemGroup]?
    
    lazy var btnToCatalog: UIButton = {
        var btn = UIButton()
        btn.setTitle("Каталог", for: .normal)
        btn.addTarget(self, action: #selector(didTapCatalogBtn(sender:)), for: .touchUpInside)
        btn.layer.cornerRadius = 1
        return btn
    }()
    
    @objc func didTapCatalogBtn(sender: UIButton) {
        let vc = CatalogViewController(items: itemTree)
        if let navController = window?.rootViewController as? UINavigationController {
            navController.pushViewController(vc, animated: true)
        }
    }
    
    init(rootVC: MenuViewController) {
        super.init(frame: CGRect.zero)
        backgroundColor = .lightGray
        setupView()
    }
    
    func setupView() {
        [btnToCatalog].forEach { v in
            v.translatesAutoresizingMaskIntoConstraints = false
            addSubview(v)
        }
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            btnToCatalog.widthAnchor.constraint(equalToConstant: 100),
            btnToCatalog.heightAnchor.constraint(equalToConstant: 44),
            btnToCatalog.centerXAnchor.constraint(equalTo: centerXAnchor),
            btnToCatalog.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
