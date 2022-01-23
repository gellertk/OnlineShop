//
//  ItemViewController.swift
//  OnlineShop
//
//  Created by Кирилл  Геллерт on 22.01.2022.
//

import UIKit

class ItemViewController: UIViewController {

    let currentItem: Item
    
    lazy var activityButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .done, target: self, action: #selector(didTapActivityButton(sender:)))
        barButton.tintColor = .black
        return barButton
    }()
    
    lazy var itemView: UIView = {
        let view = ItemView(currentItem: currentItem)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    init(currentItem: Item) {
        self.currentItem = currentItem
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        navigationController?.navigationBar.topItem?.title = ""
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = activityButton
        setupView()
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
