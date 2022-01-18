//
//  ProductList.swift
//  OnlineShop
//
//  Created by Кирилл  Геллерт on 09.01.2022.
//

import UIKit

class Catalog: UIView {
    
    let rootVC: CatalogViewController
    var items: [ItemGroup]
    var lastAddedBottomAnchor: NSLayoutYAxisAnchor
    
    init(rootVC: CatalogViewController, items: [ItemGroup]) {
        self.rootVC = rootVC
        self.items = items
        self.lastAddedBottomAnchor = NSLayoutYAxisAnchor()
        super.init(frame: CGRect.zero)
        backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        items = items[0].items
        for index in items.indices {
            let viewItem = UIView()
            viewItem.translatesAutoresizingMaskIntoConstraints = false
            viewItem.backgroundColor = .white
            addSubview(viewItem)
            
            let lblItemName = UILabel()
            lblItemName.text = items[index].name
            lblItemName.translatesAutoresizingMaskIntoConstraints = false
            addSubview(lblItemName)
            
            let imgItem = UIImageView()
            imgItem.image = UIImage(named: items[index].imgName)
            imgItem.translatesAutoresizingMaskIntoConstraints = false
            addSubview(imgItem)
            setupConstraints(viewItem, imgItem, lblItemName, index)
            lastAddedBottomAnchor = viewItem.bottomAnchor
        }
    }
    
    func setupConstraints(_ viewItem: UIView, _ imgItem: UIImageView, _ lblItemName: UILabel, _ index: Int) {
        let itemLeadingAnchor = (index % 2 == 1) ? centerXAnchor: leadingAnchor
        let itemTrailingAnchor = (index % 2 == 1) ? trailingAnchor : centerXAnchor
        let itemTopAnchor = (index > 1) ? lastAddedBottomAnchor : safeAreaLayoutGuide.topAnchor
       
        NSLayoutConstraint.activate([
            viewItem.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.51),
            viewItem.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.15),
            viewItem.leadingAnchor.constraint(equalTo: itemLeadingAnchor, constant: 10),
            viewItem.trailingAnchor.constraint(equalTo: itemTrailingAnchor, constant: -10),
            viewItem.topAnchor.constraint(equalTo: itemTopAnchor),
            
            lblItemName.centerYAnchor.constraint(equalTo: viewItem.centerYAnchor),
            lblItemName.leadingAnchor.constraint(equalTo: viewItem.leadingAnchor, constant: 10),
            //lblItemName.trailingAnchor.constraint(equalTo: viewItem, constant: 10),
        ])
    }
    
}
