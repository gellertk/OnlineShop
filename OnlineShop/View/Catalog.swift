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
    var addedView = [UIView]()
    var viewsItems = [UIView : [ItemGroup]]()
    
    init(rootVC: CatalogViewController, items: [ItemGroup]) {
        self.rootVC = rootVC
        self.items = items
        super.init(frame: CGRect.zero)
        backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        for index in items.indices {
            let viewItem = UIView()
            viewItem.translatesAutoresizingMaskIntoConstraints = false
            viewItem.backgroundColor = .white
            viewItem.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapItem(sender:))))
            addSubview(viewItem)
            viewsItems[viewItem] = items[index].items
           
            let lblItemName = UILabel()
            lblItemName.text = items[index].name
            lblItemName.translatesAutoresizingMaskIntoConstraints = false
            addSubview(lblItemName)
            
            let imgItem = UIImageView()
            imgItem.image = UIImage(named: items[index].imgName)
            imgItem.translatesAutoresizingMaskIntoConstraints = false
            addSubview(imgItem)
            setupConstraints(viewItem, imgItem, lblItemName, index)
            addedView.append(viewItem)
        }
    }
    
    @objc func didTapItem(sender: UITapGestureRecognizer) {
        if let viewTapped = sender.view, let childItems = viewsItems[viewTapped] {
            let vc = CatalogViewController(items: childItems)
            if let navController = window?.rootViewController as? UINavigationController {
                navController.pushViewController(vc, animated: true)
            }
        }
    }
    
    func setupConstraints(_ viewItem: UIView, _ imgItem: UIImageView, _ lblItemName: UILabel, _ index: Int) {
        let lastView = addedView.last ?? UIView()
        let itemLeadingAnchor = (index % 2 == 1) ? centerXAnchor: leadingAnchor
        let itemTrailingAnchor = (index % 2 == 1) ? trailingAnchor : centerXAnchor
        var constantTopAnchor = CGFloat(10)
        var itemTopAnchor = safeAreaLayoutGuide.topAnchor

        if index > 1 {
            itemTopAnchor = index % 2 == 1 ? lastView.topAnchor : lastView.bottomAnchor
            constantTopAnchor = index % 2 == 1 ? CGFloat(0) : constantTopAnchor
        }
        
        NSLayoutConstraint.activate([
            viewItem.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.50),
            viewItem.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.15),
            viewItem.leadingAnchor.constraint(equalTo: itemLeadingAnchor, constant: 10),
            viewItem.trailingAnchor.constraint(equalTo: itemTrailingAnchor, constant: -10),
            viewItem.topAnchor.constraint(equalTo: itemTopAnchor, constant: constantTopAnchor),
            
            lblItemName.centerYAnchor.constraint(equalTo: viewItem.centerYAnchor),
            lblItemName.leadingAnchor.constraint(equalTo: viewItem.leadingAnchor, constant: 10),
        ])
    }
    
}
