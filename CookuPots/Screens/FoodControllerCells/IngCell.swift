//
//  IngCell.swift
//  CookuPots
//
//  Created by Sebulla on 08/04/2022.
//

import UIKit
import Kingfisher

class IngCell: UICollectionViewCell {
    private var allIngredients: [Ingredient] = []
    private var instructions: [Step] = [] {
        didSet {
            for instruction in instructions {
                allIngredients.append(contentsOf: instruction.ingredients)
            }
            // reloadData() ??
        }
    }
//    var instructions: [Step] = []
    var ingredients: [Ingredient] = []
    
    let button: UIButton = {
            let btn = UIButton(type: .system)
            btn.setImage(UIImage(systemName: "cart.badge.plus"), for: .normal)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 10)
            btn.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
            btn.becomeFirstResponder()
            return btn
        }()
       
    @objc func didTapButton() {
        
        print("button tapped")
    }
    
    let label: UILabel = {
        let label = UILabel()
        label.backgroundColor = .gray
        label.text = "Here you will find ingredients soon..."
        label.font = UIFont(name: "HoeflerText-Regular", size: 16)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.setContentHuggingPriority(.defaultLow, for: .vertical)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
 
    func setUpViews() {
        
        addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        button.widthAnchor.constraint(equalToConstant: 80).isActive = true
        button.heightAnchor.constraint(equalTo: contentView.heightAnchor).isActive = true
        button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        
        
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        label.trailingAnchor.constraint(equalTo: button.leadingAnchor).isActive = true
        label.heightAnchor.constraint(equalTo: contentView.heightAnchor).isActive = true
 
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .green
        setUpViews()
        self.contentView.isUserInteractionEnabled = false
        
}
 
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
