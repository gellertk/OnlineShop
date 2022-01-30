//
//  CustomItem.swift
//  OnlineShop
//
//  Created by Кирилл  Геллерт on 21.01.2022.
//

import UIKit

class ItemGroupView: UIView {
    
    var item: ItemGroup

    lazy var itemNameLabel: UILabel = {
        let label = UILabel()
        label.text = item.name
        label.font = UIFont.systemFont(ofSize: 13, weight: .light)
        return label
    }()
    
    lazy var itemImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: item.imgName) ?? UIImage(named: "EmptyPhoto")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    init(item: ItemGroup, tag: Int) {
        self.item = item
        super.init(frame: CGRect.zero)
        self.tag = tag
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 2, height: 2)
        layer.shadowOpacity = 0.6
        layer.shadowRadius = 5
        layer.cornerRadius = 10
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
        [itemImageView, itemNameLabel].forEach { newView in
            newView.translatesAutoresizingMaskIntoConstraints = false
            addSubview(newView)
        }
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            itemNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            itemNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            
            itemImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            itemImageView.topAnchor.constraint(equalTo: itemNameLabel.bottomAnchor, constant: 5),
            itemImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
    
}
