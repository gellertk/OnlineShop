//
//  ProductList.swift
//  OnlineShop
//
//  Created by Кирилл  Геллерт on 09.01.2022.
//

import UIKit

class Catalog: UIView {
    
    let catalogViewController: CatalogViewController
    var items: [ItemGroup]
    var addedViews: [UIView] = []
    var viewsItems: [UIView: [ItemGroup]] = [:]
    
    init(catalogViewController: CatalogViewController, items: [ItemGroup]) {
        self.catalogViewController = catalogViewController
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
            let itemView = UIView()
            itemView.translatesAutoresizingMaskIntoConstraints = false
            itemView.backgroundColor = .white
            itemView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapItem(sender:))))
            addSubview(itemView)
            viewsItems[itemView] = items[index].items
           
            let itemNameLabel = UILabel()
            itemNameLabel.text = items[index].name
            itemNameLabel.translatesAutoresizingMaskIntoConstraints = false
            itemNameLabel.font = UIFont.systemFont(ofSize: 13)
            addSubview(itemNameLabel)
            
            let itemImageView = UIImageView()
            itemImageView.image = UIImage(named: items[index].imgName)
            itemImageView.translatesAutoresizingMaskIntoConstraints = false
            itemImageView.contentMode = .scaleAspectFit
            addSubview(itemImageView)
            setupConstraints(itemView, itemImageView, itemNameLabel, index)
            addedViews.append(itemView)
        }
    }
    
    @objc func didTapItem(sender: UITapGestureRecognizer) {
        if let tappedView = sender.view, let childItems = viewsItems[tappedView] {
            let catalogViewController = CatalogViewController(with: childItems)
            if let navigationViewController = window?.rootViewController as? UINavigationController {
                navigationViewController.pushViewController(catalogViewController, animated: true)
            }
        }
    }
    
    func setupConstraints(_ itemView: UIView, _ itemImageView: UIImageView, _ itemNameLabel: UILabel, _ index: Int) {
        let isLeftSideView = (index % 2 == 0)
        let lastAddedView = addedViews.last ?? UIView()
        let itemLeadingAnchor = isLeftSideView ? leadingAnchor : centerXAnchor
        let itemTrailingAnchor = isLeftSideView ? centerXAnchor : trailingAnchor
        var constantTopAnchor = CGFloat(10)
        var itemTopAnchor = safeAreaLayoutGuide.topAnchor

        if index > 1 {
            itemTopAnchor = isLeftSideView ? lastAddedView.bottomAnchor : lastAddedView.topAnchor
            constantTopAnchor = isLeftSideView ? constantTopAnchor : CGFloat(0)
        }
        
        NSLayoutConstraint.activate([
            itemView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.50),
            itemView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.15),
            itemView.leadingAnchor.constraint(equalTo: itemLeadingAnchor, constant: 10),
            itemView.trailingAnchor.constraint(equalTo: itemTrailingAnchor, constant: -10),
            itemView.topAnchor.constraint(equalTo: itemTopAnchor, constant: constantTopAnchor),
            
            itemNameLabel.centerYAnchor.constraint(equalTo: itemView.centerYAnchor),
            itemNameLabel.leadingAnchor.constraint(equalTo: itemView.leadingAnchor, constant: 10),
            itemNameLabel.trailingAnchor.constraint(equalTo: itemImageView.leadingAnchor, constant: -10),
            
            itemImageView.widthAnchor.constraint(equalToConstant: 70),
            itemImageView.heightAnchor.constraint(equalToConstant: 70),
            itemImageView.leadingAnchor.constraint(equalTo: itemNameLabel.trailingAnchor, constant: 10),
            itemImageView.trailingAnchor.constraint(equalTo: itemView.trailingAnchor, constant: -20),
            //itemImageView.centerYAnchor.constraint(equalTo: itemView.trailingAnchor, constant: -20),
            
            itemImageView.topAnchor.constraint(equalTo: itemView.topAnchor, constant: 15),
            itemImageView.bottomAnchor.constraint(equalTo: itemView.bottomAnchor, constant: -15)
        ])
    }
    
}
