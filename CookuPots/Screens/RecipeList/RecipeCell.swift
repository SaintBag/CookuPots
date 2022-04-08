//
//  File.swift
//  CookuPots
//
//  Created by Sebulla on 28/03/2022.
//

import UIKit

class RecipeCell: UITableViewCell {
    
    var recipeImageView = UIImageView()
    
    let recipeTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HoeflerText-Regular", size: 16)
        label.textAlignment = .natural
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(recipeImageView)
        addSubview(recipeTitleLabel)
        
        configureImageView()
        configureTitleLabel()
        setImageConstrains()
        setTitleLabelConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureImageView() {
        recipeImageView.layer.cornerRadius = 10
        recipeImageView.clipsToBounds = true
        
    }
    
    func configureTitleLabel() {
        recipeTitleLabel.numberOfLines = 10
        recipeTitleLabel.adjustsFontSizeToFitWidth = true
        
    }
    
    func setImageConstrains() {
        recipeImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            recipeImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            recipeImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            recipeImageView.heightAnchor.constraint(equalToConstant: 80),
            recipeImageView.widthAnchor.constraint(equalTo: recipeTitleLabel.heightAnchor, multiplier: 16/9)
        ])
    }
    func setTitleLabelConstrains() {
        recipeTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        recipeTitleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        recipeTitleLabel.leadingAnchor.constraint(equalTo: recipeImageView.trailingAnchor, constant: 20).isActive = true
        recipeTitleLabel.heightAnchor.constraint(equalToConstant: 80).isActive = true
        recipeTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
        
    }
    
}
