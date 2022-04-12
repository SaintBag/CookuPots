//
//  IngCell.swift
//  CookuPots
//
//  Created by Sebulla on 08/04/2022.
//

import UIKit

class IngCell: UICollectionViewCell {
    
    var addToCartAction: (() -> Void)?
    
    private lazy var button: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(systemName: "cart.badge.plus"), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        btn.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        return btn
    }()
    
    @objc func didTapButton() {
        addToCartAction?()
    }
    
    private lazy var ingredientLabel: UILabel = {
        let label = UILabel()
        //        label.backgroundColor = .gray
        label.text = "Here you will find ingredients soon..."
        label.font = UIFont(name: "HoeflerText-Regular", size: 16)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.setContentHuggingPriority(.defaultLow, for: .vertical)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        backgroundColor = .green
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setIngredientLabel(text: String) {
        ingredientLabel.text = text
    }
    
    private func setUpViews() {
        
        contentView.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        button.widthAnchor.constraint(equalToConstant: 80).isActive = true
        button.heightAnchor.constraint(equalTo: contentView.heightAnchor).isActive = true
        button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        
        // constraints to contentView
        contentView.addSubview(ingredientLabel)
        ingredientLabel.translatesAutoresizingMaskIntoConstraints = false
        ingredientLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        ingredientLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12).isActive = true
        ingredientLabel.trailingAnchor.constraint(equalTo: button.leadingAnchor).isActive = true
        ingredientLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor).isActive = true
        
    }
}
