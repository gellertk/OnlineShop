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
    "white": UIColor(white: 0.92, alpha: 1),
    "purple": .purple,
    "green": .green,
    "gold": .systemYellow
]

protocol ItemViewDelegate: AnyObject {
    func valueChangeItemViewSegments(selectedSegmentColorIndex: Int?,
                                     selectedSegmentMemoryIndex: Int?,
                                     selectedSegmentRamIndex: Int?)
    func getFromStock(color: String, memory: String, ram: String) -> Item?
}

class ItemView: UIView {
    
    var item: Item
    weak var itemViewControllerDelegate: ItemViewDelegate?
    
    lazy var itemImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var whiteBackgroundView: UIView = {
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
    
    lazy var colorLabel: UILabel? = {
        guard item.itemGroup.colors.count > 0 else {
            return nil
        }
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.text = "Цвет:"
        return label
    }()
    
    lazy var memoryLabel: UILabel? = {
        guard item.itemGroup.memorys.count > 0 else {
            return nil
        }
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.text = "Память:"
        return label
    }()
    
    lazy var ramLabel: UILabel? = {
        guard item.itemGroup.rams.count > 0 else {
            return nil
        }
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.text = "Оперативная память:"
        return label
    }()
    
    lazy var colorSegmentedControl: CustomColorSegmentedView? = {
        guard let selectedSegmentIndex = item.itemGroup.colors.firstIndex(of: item.color) else {
            return nil
        }
        let segmentedControl = CustomColorSegmentedView(colors: item.itemGroup.colors, selectedSegmentIndex: selectedSegmentIndex)
        segmentedControl.itemViewDelegate = self
        return segmentedControl
    }()
    
    lazy var memorySegmentedControl: UISegmentedControl? = {
        guard let selectedSegmentIndex = item.itemGroup.memorys.firstIndex(of: item.memory),
              let delegate = itemViewControllerDelegate else {
            return nil
        }
        let segmentedControl = UISegmentedControl(items: item.itemGroup.memorys.convertToFormattedMemoryCollection())
        segmentedControl.addTarget(self, action: #selector(memorySegmentValueChange(sender:)), for: .valueChanged)
        segmentedControl.selectedSegmentIndex = selectedSegmentIndex
        return segmentedControl
    }()
    
    lazy var ramSegmentedControl: UISegmentedControl? = {
        guard let selectedSegmentIndex = item.itemGroup.rams.firstIndex(of: item.ram) else {
            return nil
        }
        let segmentedControl = UISegmentedControl(items: item.itemGroup.rams.convertToFormattedMemoryCollection())
        segmentedControl.selectedSegmentIndex = selectedSegmentIndex
        return segmentedControl
    }()
    
    lazy var toCartButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(didTapToCartButton(sender:)), for: .touchUpInside)
        button.layer.cornerRadius = 10
        return button
    }()
    
    init(currentItem: Item, delegate: ItemViewController) {
        self.item = currentItem
        self.itemViewControllerDelegate = delegate
        super.init(frame: CGRect.zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func memorySegmentValueChange(sender: UISegmentedControl) {
        guard let delegate = itemViewControllerDelegate else {
            return
        }
        delegate.valueChangeItemViewSegments(selectedSegmentColorIndex: colorSegmentedControl?.selectedSegmentIndex,
                                             selectedSegmentMemoryIndex: sender.selectedSegmentIndex,
                                             selectedSegmentRamIndex: ramSegmentedControl?.selectedSegmentIndex)
        updateSegmentsAvailability()
    }
    
    @objc func ramSegmentValueChange(sender: UISegmentedControl) {
        guard let delegate = itemViewControllerDelegate else {
            return
        }
        delegate.valueChangeItemViewSegments(selectedSegmentColorIndex: colorSegmentedControl?.selectedSegmentIndex,
                                             selectedSegmentMemoryIndex: memorySegmentedControl?.selectedSegmentIndex,
                                             selectedSegmentRamIndex: sender.selectedSegmentIndex)
    }
    
    @objc func didTapToCartButton(sender: UIButton) {
        
    }
    
    func updateSegmentsAvailability() {
        guard let itemViewControllerDelegate = itemViewControllerDelegate else {
            return
        }

        for index in item.itemGroup.memorys.indices {
            if itemViewControllerDelegate.getFromStock(color: item.color,
                                                       memory: item.itemGroup.memorys[index],
                                                       ram: item.ram) != nil {
                memorySegmentedControl?.setEnabled(true, forSegmentAt: index)
            } else {
                memorySegmentedControl?.setEnabled(false, forSegmentAt: index)
            }
        }
        
        for index in item.itemGroup.rams.indices {
            if itemViewControllerDelegate.getFromStock(color: item.color,
                                                       memory: item.memory,
                                                       ram: item.itemGroup.rams[index]) != nil {
                ramSegmentedControl?.setEnabled(true, forSegmentAt: index)
            } else {
                ramSegmentedControl?.setEnabled(false, forSegmentAt: index)
            }
        }
        
        for index in item.itemGroup.colors.indices {
            if itemViewControllerDelegate.getFromStock(color: item.itemGroup.colors[index],
                                                       memory: item.memory,
                                                       ram: item.ram) != nil {
                colorSegmentedControl?.setEnabled(true, forSegmentAt: index)
            } else {
                colorSegmentedControl?.setEnabled(false, forSegmentAt: index)
            }
        }
    }
    
    func setupView() {
        setupItem(isInStock: true)
        backgroundColor = UIColor(white: 0.97, alpha: 1)
        let viewCollection = [
            itemImageView,
            whiteBackgroundView,
            nameLabel,
            priceLabel,
            toCartButton
        ]
        viewCollection.forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
            addSubview(view)
        }
        let optionalViewCollection = [
            colorLabel,
            colorSegmentedControl,
            memoryLabel,
            memorySegmentedControl,
            ramLabel,
            ramSegmentedControl
        ]
        optionalViewCollection.forEach { optView in
            if let optView = optView {
                optView.translatesAutoresizingMaskIntoConstraints = false
                addSubview(optView)
            }
        }
        sendSubviewToBack(whiteBackgroundView)
        setupConstraints()
    }
    
    func setupItem(isInStock: Bool) {
        updateSegmentsAvailability()
        priceLabel.text = "\(item.price) Р"
        nameLabel.text = "\(item.brand) \(item.name), \(item.memory.getFormattedSize()), \"\(item.color)\""
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
            
            whiteBackgroundView.topAnchor.constraint(equalTo: topAnchor),
            whiteBackgroundView.bottomAnchor.constraint(equalTo: itemImageView.bottomAnchor),
            whiteBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            whiteBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),

            nameLabel.topAnchor.constraint(equalTo: itemImageView.bottomAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 20),
            
            priceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 30),
            priceLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
        ])        
        setupOptionalViewConstraints()
    }
    
    func setupOptionalViewConstraints() {
        
        var viewUnderPriceBottomAnchor = priceLabel.bottomAnchor
        
        if let colorLabel = colorLabel,
           let colorSegmentedControl = colorSegmentedControl {
            
            let colorsCount = item.itemGroup.colors.count
            let colorSegmentedControlWidthAnchor = CGFloat(colorsCount * 42)
            
            NSLayoutConstraint.activate([
                colorLabel.topAnchor.constraint(equalTo: viewUnderPriceBottomAnchor, constant: 25),
                colorLabel.leadingAnchor.constraint(equalTo: priceLabel.leadingAnchor),
                
                colorSegmentedControl.centerYAnchor.constraint(equalTo: colorLabel.centerYAnchor),
                colorSegmentedControl.leadingAnchor.constraint(equalTo: colorLabel.trailingAnchor, constant: 20),
                colorSegmentedControl.widthAnchor.constraint(equalToConstant: colorSegmentedControlWidthAnchor),
                colorSegmentedControl.heightAnchor.constraint(equalToConstant: 38)
            ])
            viewUnderPriceBottomAnchor = colorSegmentedControl.bottomAnchor
        }
        
        if let memoryLabel = memoryLabel,
           let memorySegmentedControl = memorySegmentedControl {
            
            NSLayoutConstraint.activate([
                memoryLabel.topAnchor.constraint(equalTo: viewUnderPriceBottomAnchor, constant: 25),
                memoryLabel.leadingAnchor.constraint(equalTo: priceLabel.leadingAnchor),
                
                memorySegmentedControl.centerYAnchor.constraint(equalTo: memoryLabel.centerYAnchor),
                memorySegmentedControl.leadingAnchor.constraint(equalTo: memoryLabel.trailingAnchor, constant: 20),
            ])
            viewUnderPriceBottomAnchor = memorySegmentedControl.bottomAnchor
        }
        
        if let ramLabel = ramLabel,
           let ramSegmentedControl = ramSegmentedControl {
            
            NSLayoutConstraint.activate([
                ramLabel.topAnchor.constraint(equalTo: viewUnderPriceBottomAnchor, constant: 25),
                ramLabel.leadingAnchor.constraint(equalTo: priceLabel.leadingAnchor),
                
                ramSegmentedControl.centerYAnchor.constraint(equalTo: ramLabel.centerYAnchor),
                ramSegmentedControl.leadingAnchor.constraint(equalTo: ramLabel.trailingAnchor, constant: 20),
            ])
        }
        
        NSLayoutConstraint.activate([
            toCartButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            toCartButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            toCartButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30)
        ])
    }
    
}

extension ItemView: CustomColorSegmentedViewDelegate {
    
    func didTapColorButton(selectedSegmentIndex: Int) {
        guard let delegate = itemViewControllerDelegate else {
            return
        }
        delegate.valueChangeItemViewSegments(selectedSegmentColorIndex: selectedSegmentIndex,
                                             selectedSegmentMemoryIndex: memorySegmentedControl?.selectedSegmentIndex,
                                             selectedSegmentRamIndex: ramSegmentedControl?.selectedSegmentIndex)
    }
    
}
