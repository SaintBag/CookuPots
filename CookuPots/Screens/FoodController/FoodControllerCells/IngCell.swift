//
//  IngCell.swift
//  CookuPots
//
//  Created by Sebulla on 08/04/2022.
//

import UIKit

class IngCell: UICollectionViewCell {
    
    var addToCartAction: ((Bool) -> Void)?
    var removeFromCartAction: (() -> Void)?
    
    private lazy var button: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(systemName: "cart.badge.plus"), for: .normal)
        btn.setImage(UIImage(systemName: "trash"), for: .selected)
        btn.tintColor = .systemPurple
        btn.addTarget(self, action: #selector(self.didTapButton), for: .touchUpInside)
        return btn
    }()
    
    @objc func didTapButton() {
        let wasSelected = button.isSelected
        addToCartAction?(wasSelected)
        button.isSelected = !wasSelected
    }
    
    private lazy var ingredientLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "GillSans", size: 16)
        label.textColor = .systemPurple
        label.textAlignment = .justified
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.setContentHuggingPriority(.defaultLow, for: .vertical)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setIngredientLabel(text: String) {
        ingredientLabel.text = text
    }
    
    func setButtonState(isSelected: Bool) {
        button.isSelected = isSelected
    }
    
    private func setUpViews() {
        
        contentView.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        button.widthAnchor.constraint(equalToConstant: 40).isActive = true
        button.heightAnchor.constraint(equalTo: contentView.heightAnchor).isActive = true
        button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true

        contentView.addSubview(ingredientLabel)
        ingredientLabel.translatesAutoresizingMaskIntoConstraints = false
        ingredientLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 2).isActive = true
        ingredientLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12).isActive = true
        ingredientLabel.trailingAnchor.constraint(equalTo: button.leadingAnchor).isActive = true
        ingredientLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -2).isActive = true
        
    }
}
