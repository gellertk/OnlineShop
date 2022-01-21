//
//  ItemView.swift
//  OnlineShop
//
//  Created by Кирилл  Геллерт on 21.01.2022.
//

import UIKit

class ItemView: UIView {
    
    let itemGroup: ItemGroup
    let currentItem: Item
    
    lazy var activityButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(didTapActivityButton(sender:)), for: .touchUpInside)
        button.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        return button
    }()
    
    lazy var itemImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: currentItem.imgName) ?? UIImage(named: "EmptyPhoto")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Apple \(itemGroup.name), \(currentItem.memory) ГБ, \(currentItem.color)"
        label.font = UIFont.systemFont(ofSize: 13, weight: .light)
        return label
    }()
    
    lazy var itemPrice: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.text = "\(currentItem.price) Р"
        return label
    }()
    
    lazy var colorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10, weight: .light)
        label.text = "Цвет"
        return label
    }()
    
    lazy var memoryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10, weight: .light)
        label.text = "Память"
        return label
    }()
    
    lazy var colorSegmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl()
        return segmentedControl
    }()
    
    lazy var memorySegmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl()
        return segmentedControl
    }()
    
    lazy var ramSegmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl()
        return segmentedControl
    }()
    
    lazy var toCartButton: UIButton = {
        let button = UIButton()
        button.setTitle("В корзину", for: .normal)
        button.backgroundColor = .systemPink
        button.addTarget(self, action: #selector(didTapToCartButton(sender:)), for: .touchUpInside)
        return button
    }()
    
    init(itemGroup: ItemGroup, currentItem: Item) {
        self.itemGroup = itemGroup
        self.currentItem = currentItem
        super.init(frame: CGRect.zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func didTapToCartButton(sender: UIButton) {
        
    }
    
    @objc func didTapActivityButton(sender: UIButton) {
        
    }
    
    func setupView() {
        setupConstraints()
        [activityButton, itemImageView, nameLabel, itemPrice, colorLabel, memoryLabel, toCartButton].forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
            addSubview(view)
        }
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            itemImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
//            itemImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
//            itemImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            itemImageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            itemImageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.53),
            
            nameLabel.topAnchor.constraint(equalTo: itemImageView.bottomAnchor, constant: -50),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 20),
            
            colorLabel.centerXAnchor.constraint(equalTo: nameLabel.centerXAnchor),
            colorLabel.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor, constant: 20),
            
            memoryLabel.centerXAnchor.constraint(equalTo: colorLabel.centerXAnchor),
            memoryLabel.centerYAnchor.constraint(equalTo: colorLabel.centerYAnchor, constant: 20),
            
            toCartButton.centerYAnchor.constraint(equalTo: memoryLabel.centerYAnchor, constant: 20),
            toCartButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            toCartButton.trailingAnchor.constraint(equalTo: trailingAnchor)

        ])
    }
    
}
