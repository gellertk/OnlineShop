//
//  ColorSegmentedControl.swift
//  OnlineShop
//
//  Created by Кирилл  Геллерт on 22.01.2022.
//

import UIKit

class ColorSegmentedView: UIControl {
    
    var colors: [String] = []
    var selectedSegmentIndex = 0
    
    lazy var colorButtons: [UIButton] = {
        var buttons = [UIButton]()
        for index in colors.indices {
            let button = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 25))
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
        guard button.tag != selectedSegmentIndex else { return }
        
        colorButtons[selectedSegmentIndex].layer.borderWidth = 0
        colorButtons[selectedSegmentIndex].layer.borderColor = nil
      
        button.layer.borderWidth = 3
        button.layer.borderColor = UIColor(red: 1, green: 0, blue: 0, alpha: 1).cgColor
        selectedSegmentIndex = button.tag
        sendActions(for: .valueChanged)
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
