//
//  ItemView.swift
//  OnlineShop
//
//  Created by Кирилл  Геллерт on 21.01.2022.
//

import UIKit

let stringColorDic: [String: UIColor] = [
    "silver": .lightGray,
    "gray": .gray,
    "pink": .systemPink,
    "blue": .blue,
    "red":  .red,
    "black": .black,
    "white": .white,
    "purple": .purple,
    "green": .green,
    "gold": .systemYellow
]

class ItemView: UIView {
    
    let itemGroup: ItemGroup
    var item: Item
    
    lazy var activityButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(didTapActivityButton(sender:)), for: .touchUpInside)
        button.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        return button
    }()
    
    lazy var itemImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .light)
        return label
    }()
    
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22, weight: .heavy)
        return label
    }()
    
    lazy var colorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.text = "Цвет:"
        return label
    }()
    
    lazy var memoryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.text = "Память:"
        return label
    }()
    
    lazy var colorSegmentedControl: UIView = {
        let segmentedControl = ColorSegmentedControlView(colors: itemGroup.possibleColors ?? [])
        return segmentedControl
    }()
    
    lazy var memorySegmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: itemGroup.possibleMemory)
        segmentedControl.selectedSegmentIndex = 0
        return segmentedControl
    }()
    
    lazy var ramSegmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: itemGroup.possibleRam)
        return segmentedControl
    }()
    
    lazy var toCartButton: UIButton = {
        let button = UIButton()
        button.setTitle("В корзину", for: .normal)
        button.backgroundColor = .systemPink
        button.addTarget(self, action: #selector(didTapToCartButton(sender:)), for: .touchUpInside)
        return button
    }()
    
    init(currentItemGroup: ItemGroup, currentItem: Item) {
        self.itemGroup = currentItemGroup
        self.item = currentItem
        super.init(frame: CGRect.zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func colorDidChange(_ segmentedControl: UISegmentedControl) {
        if let chosenColor = itemGroup.possibleColors?[segmentedControl.selectedSegmentIndex],
           let items = itemGroup.items as? [Item],
           let chosenItem = items.first(where: { $0.color == chosenColor && $0.memory == item.memory }) {
            item = chosenItem
            setupItem()
        }
    }
    
    @objc func didTapToCartButton(sender: UIButton) {
        
    }
    
    @objc func didTapActivityButton(sender: UIButton) {
        
    }
    
    func setupView() {
        setupItem()
        backgroundColor = .white
        [activityButton, itemImageView, nameLabel, priceLabel, colorLabel, colorSegmentedControl, memoryLabel, memorySegmentedControl, toCartButton].forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
            addSubview(view)
        }
        setupConstraints()
    }
    
    func setupItem() {
        priceLabel.text = "\(item.price) Р"
        nameLabel.text = "Apple \(item.name), \(item.memory) ГБ, \(item.color)"
        itemImageView.image = UIImage(named: item.imgName) ?? UIImage(named: "EmptyPhoto")
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            itemImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            itemImageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            itemImageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.50),
            //itemImageView.bottomAnchor.constraint(equalTo: nameLabel.topAnchor, constant: -10),
            
            nameLabel.topAnchor.constraint(equalTo: itemImageView.bottomAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 20),
            
            priceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 30),
            priceLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            
            colorLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 30),
            colorLabel.leadingAnchor.constraint(equalTo: priceLabel.leadingAnchor),
            
            colorSegmentedControl.centerYAnchor.constraint(equalTo: colorLabel.centerYAnchor),
            colorSegmentedControl.leadingAnchor.constraint(equalTo: colorLabel.trailingAnchor, constant: 20),
            
            memoryLabel.topAnchor.constraint(equalTo: colorLabel.bottomAnchor, constant: 30),
            memoryLabel.leadingAnchor.constraint(equalTo: colorLabel.leadingAnchor),
            
            //memorySegmentedControl.bottomAnchor.constraint(equalTo: memoryLabel.bottomAnchor, constant: 20),
            
            memorySegmentedControl.centerYAnchor.constraint(equalTo: memoryLabel.centerYAnchor),
            memorySegmentedControl.leadingAnchor.constraint(equalTo: memoryLabel.trailingAnchor, constant: 20),
            
            toCartButton.topAnchor.constraint(equalTo: memoryLabel.bottomAnchor, constant: 50),
            toCartButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            toCartButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
    
}
