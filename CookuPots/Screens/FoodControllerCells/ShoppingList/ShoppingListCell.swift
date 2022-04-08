//
//  ShoppingListCell.swift
//  CookuPots
//
//  Created by Sebulla on 08/04/2022.
//
import UIKit

class ShoppingListCell: UITableViewCell {
    
    let button: UIButton = {
            let btn = UIButton(type: .system)
            btn.setImage(UIImage(systemName: "cart.badge.plus"), for: .normal)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 10)
            btn.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
            btn.becomeFirstResponder()
            btn.isUserInteractionEnabled = false
            return btn
        }()
    
    let ingredientsLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont(name: "HoeflerText-BlackItalic", size: 20)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentHuggingPriority(.defaultLow, for: .vertical)
        return label
    }()
    
    @objc func didTapButton() {
        print("tapped")
    }
  
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(button)
        addSubview(ingredientsLabel)
        setButtonConstrains()
        setTitleLabelConstrains()
        self.contentView.isUserInteractionEnabled = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    
    func setButtonConstrains() {
        button.translatesAutoresizingMaskIntoConstraints = false
        button.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        button.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        button.heightAnchor.constraint(equalToConstant: 80).isActive = true
        button.widthAnchor.constraint(equalTo: ingredientsLabel.heightAnchor, multiplier: 16/9).isActive = true
    }
    
    func setTitleLabelConstrains() {
        ingredientsLabel.translatesAutoresizingMaskIntoConstraints = false
        ingredientsLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        ingredientsLabel.leadingAnchor.constraint(equalTo: button.trailingAnchor, constant: 20).isActive = true
        ingredientsLabel.heightAnchor.constraint(equalToConstant: 80).isActive = true
        ingredientsLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
        
    }
    
}

