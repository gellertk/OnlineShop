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
    "white": UIColor(white: 0.95, alpha: 1),
    "purple": .purple,
    "green": .green,
    "gold": .systemYellow
]

protocol ItemViewDelegate: AnyObject {
    func itemViewColorSegmentsValueChange(selectedSegmentColorIndex: Int, selectedSegmentMemoryIndex: Int)
}

class ItemView: UIView {
    
    var item: Item
    weak var delegate: ItemViewDelegate?
    
    lazy var itemImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var whiteView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
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
    
    lazy var colorSegmentedControl: ColorSegmentedView = {
        let segmentedControl = ColorSegmentedView(colors: item.itemGroup.colors ?? [])
        segmentedControl.addTarget(self, action: #selector(colorSegmentValueChange(sender:)), for: .valueChanged)
        return segmentedControl
    }()
    
    lazy var memorySegmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: item.itemGroup.memorys)
        segmentedControl.addTarget(self, action: #selector(memorySegmentValueChange(sender:)), for: .valueChanged)
        segmentedControl.selectedSegmentIndex = 0
        return segmentedControl
    }()
    
    lazy var ramSegmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: item.itemGroup.rams)
        return segmentedControl
    }()
    
    lazy var toCartButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(didTapToCartButton(sender:)), for: .touchUpInside)
        return button
    }()
    
    init(currentItem: Item) {
        self.item = currentItem
        super.init(frame: CGRect.zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func colorSegmentValueChange(sender: ColorSegmentedView) {
        guard let delegate = delegate else {
            return
        }
        delegate.itemViewColorSegmentsValueChange(selectedSegmentColorIndex: sender.selectedSegmentIndex,
                                                  selectedSegmentMemoryIndex: memorySegmentedControl.selectedSegmentIndex)
    }
    
    @objc func memorySegmentValueChange(sender: UISegmentedControl) {
        guard let delegate = delegate else {
            return
        }
        delegate.itemViewColorSegmentsValueChange(selectedSegmentColorIndex: colorSegmentedControl.selectedSegmentIndex,
                                                  selectedSegmentMemoryIndex: sender.selectedSegmentIndex)
    }
    
    @objc func didTapToCartButton(sender: UIButton) {
        
    }
    
    func setupView() {
        setupItem(isInStock: true)
        backgroundColor = UIColor(white: 0.97, alpha: 1)
        [itemImageView, whiteView, nameLabel, priceLabel, colorLabel, colorSegmentedControl, memoryLabel, memorySegmentedControl, toCartButton].forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
            addSubview(view)
        }
        sendSubviewToBack(whiteView)
        setupConstraints()
    }
    
    func setupItem(isInStock: Bool) {
        priceLabel.text = "\(item.price) Р"
        nameLabel.text = "\(item.companyName) \(item.name), \(item.memory), \"\(item.color)\""
        itemImageView.image = UIImage(named: item.imgName) ?? UIImage(named: "EmptyPhoto")
        setupToCartButton(isInStock: isInStock)
    }
    
    func setupToCartButton(isInStock: Bool) {
        if isInStock {
            toCartButton.setTitle("В корзину", for: .normal)
            toCartButton.backgroundColor = .systemPink
        } else {
            toCartButton.setTitle("Нет в наличии", for: .normal)
            toCartButton.backgroundColor = .darkGray
        }
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            itemImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            itemImageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            itemImageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.50),
            
            whiteView.topAnchor.constraint(equalTo: topAnchor),
            whiteView.bottomAnchor.constraint(equalTo: itemImageView.bottomAnchor),
            whiteView.leadingAnchor.constraint(equalTo: leadingAnchor),
            whiteView.trailingAnchor.constraint(equalTo: trailingAnchor),

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
            
            memorySegmentedControl.centerYAnchor.constraint(equalTo: memoryLabel.centerYAnchor),
            memorySegmentedControl.leadingAnchor.constraint(equalTo: memoryLabel.trailingAnchor, constant: 20),
            
            toCartButton.topAnchor.constraint(equalTo: memoryLabel.bottomAnchor, constant: 50),
            toCartButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            toCartButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
    
}
