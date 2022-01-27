//
//  ColorSegmentedControl.swift
//  OnlineShop
//
//  Created by Кирилл  Геллерт on 22.01.2022.
//

import UIKit

class CustomColorSegmentedView: UIControl {
    
    var colors: [String] = []
    var selectedSegmentIndex = 0 {
        willSet {
            colorButtons[selectedSegmentIndex].layer.borderWidth = 0
            colorButtons[selectedSegmentIndex].layer.borderColor = nil
        }
        didSet {
            colorButtons[selectedSegmentIndex].layer.borderWidth = 3
            colorButtons[selectedSegmentIndex].layer.borderColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0.5).cgColor
        }
    }
    
    lazy var colorButtons: [UIButton] = {
        var buttons: [UIButton] = []
        for index in colors.indices {
            let button = CustomColorButton(color: stringColorDic[colors[index]] ?? UIColor(), index: index)
            button.customColorSegmentedViewDelegate = self
            buttons.append(button)
        }
        return buttons
    }()
    
    lazy var colorStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: colorButtons)
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
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
    
    //    func colorButtonDidTap(button: UIButton) {
    //        guard button.tag != selectedSegmentIndex else { return }
    //        selectedSegmentIndex = button.tag
    //        sendActions(for: .valueChanged)
    //    }
    
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

extension CustomColorSegmentedView: CustomColorButtonDelegate {
    
    func colorButtonDidTap(selectedSegmentIndex: Int) {
        self.selectedSegmentIndex = selectedSegmentIndex
        sendActions(for: .valueChanged)
    }
    
}
