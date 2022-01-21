//
//  ProductList.swift
//  OnlineShop
//
//  Created by Кирилл  Геллерт on 09.01.2022.
//

import UIKit

class CatalogView: UIView {
    
    let catalogViewController: CatalogViewController
    var items: [ItemGroup]
    
    init(catalogViewController: CatalogViewController, items: [ItemGroup]) {
        self.catalogViewController = catalogViewController
        self.items = items
        super.init(frame: CGRect.zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        translatesAutoresizingMaskIntoConstraints = false
        for index in items.indices {
            let itemView = CatalogItemView.init(item: items[index], tag: index)
            itemView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapCatalogItem(sender:))))
            addSubview(itemView)
            setupConstraints(itemView: itemView, index: index)
        }
    }
    
    @objc func didTapCatalogItem(sender: UITapGestureRecognizer) {
        if let tappedView = sender.view {
            let childItems = items[tappedView.tag].items
            var viewControllerToOpen = UIViewController()
            //TODO: Open right vc
            if let firstItem = childItems.first, firstItem is Item {
                viewControllerToOpen = ItemViewController(items: childItems, currentItem: firstItem)
            } else {
                viewControllerToOpen = CatalogViewController(items: childItems)
            }
            if let navigationViewController = window?.rootViewController as? UINavigationController {
                navigationViewController.pushViewController(viewControllerToOpen, animated: true)
            }
        }
    }
    
    func setupConstraints(itemView: UIView, index: Int) {
        let isLeftSideView = (index % 2 == 0)
        let itemLeadingAnchor = isLeftSideView ? leadingAnchor : centerXAnchor
        let itemTrailingAnchor = isLeftSideView ? centerXAnchor : trailingAnchor
        var constantTopAnchor = CGFloat(10)
        var itemTopAnchor = safeAreaLayoutGuide.topAnchor
        
        if let lastSetupedView = subviews.first(where: { $0.tag == index - 1 }), index > 1 {
            itemTopAnchor = isLeftSideView ? lastSetupedView.bottomAnchor : lastSetupedView.topAnchor
            constantTopAnchor = isLeftSideView ? constantTopAnchor : CGFloat(0)
        }
        
        NSLayoutConstraint.activate([
            itemView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.50),
            itemView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.15),
            itemView.leadingAnchor.constraint(equalTo: itemLeadingAnchor, constant: 10),
            itemView.trailingAnchor.constraint(equalTo: itemTrailingAnchor, constant: -10),
            itemView.topAnchor.constraint(equalTo: itemTopAnchor, constant: constantTopAnchor),
        ])
    }
    
}
