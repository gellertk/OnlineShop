//
//  ColorSegmentedControl.swift
//  OnlineShop
//
//  Created by Кирилл  Геллерт on 22.01.2022.
//

import UIKit

class ColorSegmentedControlView: UIControl {
    
    var colors: [String] = []
    
    lazy var colorButtons: [UIButton] = {
        var buttons = [UIButton]()
        for index in colors.indices {
            let button = UIButton(type: .custom)
            button.tag = index
            button.backgroundColor = stringColorDic[colors[index]]
            button.layer.cornerRadius = button.frame.width / 2
            button.clipsToBounds = true
            button.addTarget(self, action: #selector(buttonTapped(button:)), for: .touchUpInside)
            buttons.append(button)
        }
        return buttons
    }()
    
    lazy var colorStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: colorButtons)
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.spacing = 10
        return stackView
    }()
    
    init(colors: [String]) {
        self.colors = colors
        super.init(frame: CGRect.zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func buttonTapped(button: UIButton) {
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        //sendAction(<#T##action: Selector##Selector#>, to: <#T##Any?#>, for: <#T##UIEvent?#>)
    }
    
    func setupView() {
        colorStackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(colorStackView)
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            colorStackView.topAnchor.constraint(equalTo: topAnchor),
            colorStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            colorStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            colorStackView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
  
}
