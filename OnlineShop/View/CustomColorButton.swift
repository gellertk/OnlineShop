//
//  CustomColorButton.swift
//  OnlineShop
//
//  Created by Кирилл  Геллерт on 27.01.2022.
//

import UIKit

protocol CustomColorButtonDelegate: AnyObject {
    func didTapColorButton(selectedSegmentIndex: Int)
}

class CustomColorButton: UIButton {
    
    weak var customColorSegmentedViewDelegate: CustomColorButtonDelegate?
    
    required init(color: UIColor, index: Int) {
        super.init(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        setupView(color: color, index: index)
    }
    
    func setupView(color: UIColor, index: Int) {
        addTarget(self, action: #selector(colorButtonDidTap(sender:)), for: .touchUpInside)
        backgroundColor = color
        layer.cornerRadius = frame.width / 2
        tag = index
    }
    
    func setEnabled(_ enabled: Bool) {
        if enabled {
            addTarget(self, action: #selector(colorButtonDidTap(sender:)), for: .touchUpInside)
            alpha = 1
        } else {
            removeTarget(nil, action: nil, for: .touchUpInside)
            alpha = 0.2
        }
    }
    
    @objc func colorButtonDidTap(sender: CustomColorButton) {
        guard let customColorSegmentedViewDelegate = customColorSegmentedViewDelegate else {
            return
        }
        customColorSegmentedViewDelegate.didTapColorButton(selectedSegmentIndex: tag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
