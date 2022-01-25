//
//  ViewController.swift
//  OnlineShop
//
//  Created by Кирилл  Геллерт on 09.01.2022.
//

import UIKit

class CatalogViewController: UIViewController {
   
    let items: [ItemGroup]
    
    lazy var catalogView: UIView = {
        let view = CatalogView(items: items)
        view.delegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    init(items: [ItemGroup]) {
        self.items = items
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        navigationController?.navigationBar.topItem?.title = ""
        navigationController?.navigationBar.tintColor = .black
        view.addSubview(catalogView)
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            catalogView.topAnchor.constraint(equalTo: view.topAnchor),
            catalogView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            catalogView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            catalogView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }

}

extension CatalogViewController: CatalogViewDelegate {
    
    func catalogViewDidTapItemGroupView(chosenGroupIndex: Int) {
        guard let navigationController = navigationController else {
            return
        }
        let currentItemGroup = items[chosenGroupIndex]
        var viewControllerToOpen = UIViewController()
        if let item = currentItemGroup.items.first,
           item is Item,
           let item = item as? Item {
            viewControllerToOpen = ItemViewController(item: item)
        } else {
            viewControllerToOpen = CatalogViewController(items: currentItemGroup.items)
        }
        navigationController.pushViewController(viewControllerToOpen, animated: true)
    }
    
}
