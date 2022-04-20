//
//  ShoppingListCell.swift
//  CookuPots
//
//  Created by Sebulla on 08/04/2022.
//
import UIKit

class ShoppingListCell: UITableViewCell {
    
    var removeFromCartAction: (() -> Void)?
    
    private lazy var button: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(systemName: "trash"), for: .normal)
        btn.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        return btn
    }()
    
    @objc func didTapButton() {
        removeFromCartAction?()
    }
    
    private lazy var ingredientLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont(name: "HoeflerText-BlackItalic", size: 20)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentHuggingPriority(.defaultLow, for: .vertical)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setButtonConstrains()
        setTitleLabelConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setIngredientLabel(text: String) {
        ingredientLabel.text = text
    }
    
    
    func setButtonConstrains() {
        
        contentView.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        button.widthAnchor.constraint(equalToConstant: 40).isActive = true
        button.heightAnchor.constraint(equalTo: contentView.heightAnchor).isActive = true
        button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
    }
    
    func setTitleLabelConstrains() {
        
        contentView.addSubview(ingredientLabel)
        ingredientLabel.translatesAutoresizingMaskIntoConstraints = false
        ingredientLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 2).isActive = true
        ingredientLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12).isActive = true
        ingredientLabel.trailingAnchor.constraint(equalTo: button.leadingAnchor).isActive = true
        ingredientLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -2).isActive = true
        
    }
    
}

