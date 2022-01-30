//
//  ColorSegmentedControl.swift
//  OnlineShop
//
//  Created by Кирилл  Геллерт on 22.01.2022.
//

import UIKit

protocol CustomColorSegmentedViewDelegate: AnyObject {
    func didTapColorButton(selectedSegmentIndex: Int)
}

class CustomColorSegmentedView: UIView {
    
    weak var itemViewDelegate: CustomColorSegmentedViewDelegate?
    var colors: [String] = []
    var selectedSegmentIndex: Int {
        willSet {
            colorCircleViews[selectedSegmentIndex].setupBorder(isChosen: false)
        }
        didSet {
            colorCircleViews[selectedSegmentIndex].setupBorder(isChosen: true)
        }
    }
    
    lazy var colorCircleViews: [ColorCircleView] = {
        var buttons: [ColorCircleView] = []
        for index in colors.indices {
            let view = ColorCircleView(color: stringColorDic[colors[index]] ?? UIColor(), index: index)
            view.customColorSegmentedViewDelegate = self
            buttons.append(view)
        }
        return buttons
    }()
    
    lazy var colorStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: colorCircleViews)
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.spacing = 5
        return stackView
    }()
    
    init(colors: [String], selectedSegmentIndex: Int) {
        self.colors = colors
        self.selectedSegmentIndex = selectedSegmentIndex
        super.init(frame: CGRect.zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setEnabled(_ enabled: Bool, forSegmentAt segment: Int) {
        colorCircleViews[segment].setEnabled(enabled)
    }
    
    func setupView() {
        colorCircleViews[selectedSegmentIndex].setupBorder(isChosen: true)
        colorStackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(colorStackView)
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            colorStackView.topAnchor.constraint(equalTo: topAnchor),
            colorStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            colorStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            colorStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
}

extension CustomColorSegmentedView: CustomColorButtonDelegate {
    
    func didTapColorButton(selectedSegmentIndex: Int) {
        guard let itemViewDelegate = itemViewDelegate,
              self.selectedSegmentIndex != selectedSegmentIndex else {
            return
        }
        itemViewDelegate.didTapColorButton(selectedSegmentIndex: selectedSegmentIndex)
    }
    
}
