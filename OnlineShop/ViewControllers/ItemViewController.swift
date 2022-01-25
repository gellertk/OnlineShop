//
//  ItemViewController.swift
//  OnlineShop
//
//  Created by Кирилл  Геллерт on 22.01.2022.
//

import UIKit

class ItemViewController: UIViewController {

    let item: Item
    weak var delegate: ItemViewDelegate?
    
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
    
    func itemViewColorSegmentsValueChange(selectedSegmentColorIndex: Int, selectedSegmentMemoryIndex: Int) {
        guard let color = item.itemGroup.colors?[selectedSegmentColorIndex],
              let memory = item.itemGroup.memorys?[selectedSegmentMemoryIndex],
              let chosenItem = getFromStock(itemGroup: item.itemGroup, color: color, memory: memory) else {
            return
        }
        itemView.item = chosenItem
        itemView.setupItem(isInStock: chosenItem.count > 0)
    }
    
}
