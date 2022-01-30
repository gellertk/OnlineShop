//
//  ColorView.swift
//  OnlineShop
//
//  Created by Кирилл  Геллерт on 27.01.2022.
//

import UIKit

class ColorCircleView: UIView {
    
    var color: UIColor
    var index: Int
    weak var customColorSegmentedViewDelegate: CustomColorButtonDelegate? {
        didSet {
            colorButton.customColorSegmentedViewDelegate = customColorSegmentedViewDelegate
        }
    }
    
    lazy var colorButton: CustomColorButton = {
        let button = CustomColorButton(color: color, index: index)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    init(color: UIColor, index: Int) {
        self.color = color
        self.index = index
        super.init(frame: CGRect(x: 0, y: 0, width: 35, height: 35))
        setupView(color: color, index: index)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(color: UIColor, index: Int) {
        addSubview(colorButton)
        translatesAutoresizingMaskIntoConstraints = false
        setupBorder(isChosen: false)
        setupConstraints()
    }
    
    func setEnabled(_ enabled: Bool) {
        alpha = enabled ? 1 : 0.2
        colorButton.setEnabled(enabled)
    }
    
    func setupBorder(isChosen: Bool) {
        if isChosen {
            layer.borderWidth = 3
            layer.borderColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0.8).cgColor
        } else {
            layer.borderColor = UIColor.lightGray.cgColor
            layer.borderWidth = 3
            layer.cornerRadius = frame.width / 2
        }
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            colorButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            colorButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            colorButton.widthAnchor.constraint(equalToConstant: 30),
            colorButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
}
