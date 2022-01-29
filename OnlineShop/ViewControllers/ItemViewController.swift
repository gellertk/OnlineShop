//
//  ItemViewController.swift
//  OnlineShop
//
//  Created by Кирилл  Геллерт on 22.01.2022.
//

import UIKit

class ItemViewController: UIViewController {

    let item: Item
    //weak var itemViewDelegate: ItemViewDelegate?
    
    lazy var outOfStockAlertController: UIAlertController = {
        let alertController = UIAlertController(title: "Sorry", message: "Item is out of stock", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        return alertController
    }()
    
    lazy var activityButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .done, target: self, action: #selector(didTapActivityButton(sender:)))
        barButton.tintColor = .black
        return barButton
    }()
    
    lazy var itemView: ItemView = {
        let view = ItemView(currentItem: item)
        view.delegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    init(item: Item) {
        self.item = item
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        guard let navigationController = navigationController else {
            return
        }
        navigationController.navigationBar.topItem?.title = ""
        navigationItem.rightBarButtonItem = activityButton
    }
    
    @objc func didTapActivityButton(sender: UIButton) {
        
    }
    
    func setupView() {
        view.addSubview(itemView)
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            itemView.topAnchor.constraint(equalTo: view.topAnchor),
            itemView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            itemView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            itemView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}

extension ItemViewController: ItemViewDelegate {
    
    func itemViewSegmentsValueChange(selectedSegmentColorIndex: Int?,
                                     selectedSegmentMemoryIndex: Int?,
                                     selectedSegmentRamIndex: Int?) {

        let color = (selectedSegmentColorIndex != nil) ? item.itemGroup.colors[selectedSegmentColorIndex!] : ""
        let memory = (selectedSegmentMemoryIndex != nil) ? item.itemGroup.memorys[selectedSegmentMemoryIndex!] : ""
        let ram = (selectedSegmentRamIndex != nil) ? item.itemGroup.colors[selectedSegmentRamIndex!] : ""
              
        if let chosenItem = item.getFromStock(by: color, and: memory, and: ram) {
            itemView.item = chosenItem
            itemView.setupItem(isInStock: chosenItem.count > 0)
            itemView.colorSegmentedControl?.selectedSegmentIndex = selectedSegmentColorIndex ?? 0
            itemView.memorySegmentedControl?.selectedSegmentIndex = selectedSegmentMemoryIndex ?? 0
            itemView.ramSegmentedControl?.selectedSegmentIndex = selectedSegmentRamIndex ?? 0
        } else {
            itemView.setupItem(isInStock: false, isNoItemData: true)
            present(outOfStockAlertController, animated: true)
        }
    }
    
//    func
    
}
